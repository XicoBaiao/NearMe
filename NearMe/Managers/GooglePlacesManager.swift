//
//  GooglePlacesManager.swift
//  NearMe
//
//  Created by Baiao, Francisco Fonseca on 25/07/2022.
//

import Foundation
import GooglePlaces
import SwiftUI

struct GooglePlaceItem {
    let name: String
    let identifier: String
}

final class GooglePlacesManager: ObservableObject {
    
    static let shared = GooglePlacesManager()
    
    private let client = GMSPlacesClient.shared()
    
    @Published var placeImage: Image?
    
    enum PlacesError: Error {
        case failedToFind
    }
    
    private init() {}
    
    public func findPlacePhoto(place : LandmarkViewModel) {
        let token = GMSAutocompleteSessionToken.init()
        
        let filter = GMSAutocompleteFilter()
        filter.origin = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        
        let placeCity = place.getCity()
        
        client.findAutocompletePredictions(fromQuery: place.name + " " + placeCity, filter: filter, sessionToken: token, callback: { (results, error) in
            if let error = error {
                print("Autocomplete error: \(error)")
                      return
            }
            if let results = results {
                let sortedResult = results.sorted(by: {$0.distanceMeters?.intValue ?? 0 < $1.distanceMeters?.intValue ?? 0 })
                if let placeId = sortedResult.first?.placeID {
                    self.fetchPlacePhoto(placeID: placeId)
                }
                }
        })
        }
    
    private func fetchPlacePhoto(placeID: String) {
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.photos.rawValue))
        
        client.fetchPlace(fromPlaceID: placeID, placeFields: fields, sessionToken: nil, callback: {
          (place: GMSPlace?, error: Error?) in
          if let error = error {
            print("An error occurred: \(error.localizedDescription)")
            return
          }
            if let place = place, let photos = place.photos, let placePhoto = photos.first {
                self.client.loadPlacePhoto(placePhoto, callback: { (photo, error) -> Void in
                  if let error = error {
                      print("Error loading photo metadata: \(error.localizedDescription)")
                      return
                  } else {
                      if let photo = photo {
                          self.placeImage = Image(uiImage: photo)
                      }
                  }
              })
            print("The selected place is: \(place.name)")
          }
        })
    }
    
    public func findNearbyPlaces() {
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
                                                  UInt(GMSPlaceField.placeID.rawValue) | UInt(GMSPlaceField.formattedAddress.rawValue)
        | UInt(GMSPlaceField.businessStatus.rawValue) | UInt(GMSPlaceField.coordinate.rawValue) | UInt(GMSPlaceField.photos.rawValue)
        | UInt(GMSPlaceField.plusCode.rawValue) | UInt(GMSPlaceField.types.rawValue) | UInt(GMSPlaceField.viewport.rawValue))
        
        var photosData: [GMSPlacePhotoMetadata] = []

        client.findPlaceLikelihoodsFromCurrentLocation(withPlaceFields: fields, callback: {
          (placeLikelihoodList: Array<GMSPlaceLikelihood>?, error: Error?) in
          if let error = error {
            print("An error occurred: \(error.localizedDescription)")
            return
          }

          if let placeLikelihoodList = placeLikelihoodList {
            for likelihood in placeLikelihoodList {
              let place = likelihood.place
//                if ((place.types?.contains(where: {$0 == "restaurant"})) == true) {
//                    print("Current Place name \(String(describing: place.name)) at likelihood \(likelihood.likelihood)")
//                    print("Current PlaceID \(String(describing: place.placeID))")
//                      print("Current Address \(String(describing: place.formattedAddress))")
//                      print("Current Business Status\(String(describing: place.businessStatus))")
//                      print("Current Types \(String(describing: place.types))")
//                      print("Current Photos \(String(describing: place.photos))")
//                      print("Current Plus Code \(String(describing: place.plusCode))")
//                      print("Current Coordinate \(String(describing: place.coordinate))")
//                      print("Current Viewport \(String(describing: place.viewportInfo))")
//                }
                if let photo = place.photos?.first {
                    photosData.append(photo)
                }
            }
          }
            let randomInt = Int.random(in: 0..<5)
            self.client.loadPlacePhoto(photosData[randomInt], callback: { (photo, error) -> Void in
                if let error = error {
                    print("Error loading photo metadata: \(error.localizedDescription)")
                    return
                } else {
                    if let photo = photo {
                        self.placeImage = Image(uiImage: photo)
                    }
                }
            })
        })
    }
    
}

