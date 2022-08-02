//
//  LandmarkViewModel.swift
//  NearMe
//
//  Created by Baiao, Francisco Fonseca on 20/07/2022.
//

import Foundation
import MapKit
import NearMeDomain

class LocationListItemViewModel: NSObject, Identifiable, MKAnnotation {
    
    let location: Location
    
     init(location: Location) {
        self.location = location
    }
    
    var id: String { location.id ?? UUID().uuidString }
    var name: String { location.title ?? "" }
    var title: String? { location.address?.label }
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: location.position.lat, longitude: location.position.lng)
    }
    
    static var defaultLocation = LocationListItemViewModel(location: Location(title: "", id: UUID().uuidString, lang: "", type: "", address: nil, position: LocationCoordinate(lat: 0.0, lng: 0.0), access: nil, categories: nil, foodTypes: nil, contacts: nil, openingHours: nil, references: nil))

    
    func distanceToUserInKm(locationManager : LocationManager) -> String {
        var distanceString: String = ""
        if let userLocationCoord = locationManager.location?.coordinate {
            let distance = coordinate.distance(to: userLocationCoord)
            if distance >= 1000 {
                let formattedDistance = Double(round(10 * (distance/1000)) / 10)
                distanceString = "\(formattedDistance) Km"
            } else {
                distanceString = "\(Int(distance)) m"
            }
            }
        return distanceString
    }
    
    func distanceToUserInMeters(locationManager : LocationManager) -> Double {
        var distance: Double = 0.0
        if let userLocationCoord = locationManager.location?.coordinate {
            distance = coordinate.distance(to: userLocationCoord)
            }
        return distance
    }
    
}
