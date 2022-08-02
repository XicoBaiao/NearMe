//
//  LocationPreviewView.swift
//  NearMe
//
//  Created by Baiao, Francisco Fonseca on 20/07/2022.
//

import SwiftUI
import MapKit

struct LocationPreviewView: View {
    
    var location: LocationListItemViewModel
    var locationManager: LocationManager
    
    @ObservedObject var googlePlaceManager: GooglePlacesManager
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            VStack(alignment: .leading, spacing: 16) {
                imageSection
                titleSection
            }.padding(.trailing, 15)
            
            VStack(spacing: 8.0) {
                directionsButton
                nextButton
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                .offset(y: 65)
        )
        .cornerRadius(10)
        .frame(maxHeight: 250)
    }
}

//struct LocationPreviewView_Previews: PreviewProvider {
//    static var previews: some View {
//        LocationPreviewView()
//            .padding()
//    }
//}

extension LocationPreviewView {
    
    private var imageSection: some View {
        ZStack {
            if let placeImage = googlePlaceManager.placeImage {
                placeImage
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
            }
        }
        .padding(6)
        .background(Color.white)
        .cornerRadius(10)
        
    }
    
    private var titleSection: some View {

        VStack(alignment: .leading, spacing: 4.0) {
            Text(self.location.name)
                .font(.title2)
                .fontWeight(.bold)
                .minimumScaleFactor(0.01)
            
            Text(self.location.title ?? "")
                .font(.subheadline)
                .minimumScaleFactor(0.01)
            
            Text(self.location.distanceToUserInKm(locationManager: locationManager))
                .font(.subheadline)
                .minimumScaleFactor(0.01)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        
    }
    
    private var directionsButton: some View {
        
        let userLocationCoords = CLLocationCoordinate2D(latitude: locationManager.location?.coordinate.latitude ?? 0, longitude: locationManager.location?.coordinate.longitude ?? 0)
        let landmarkCoords = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        let userLocation = MKPlacemark(coordinate: userLocationCoords,
                                      addressDictionary: [:])
        let destination = MKPlacemark(coordinate: landmarkCoords,
                                addressDictionary: [:])
        
        let userLocationItem = MKMapItem(placemark: userLocation)
        let destinationItem = MKMapItem(placemark: destination)
        
        let options = [MKLaunchOptionsDirectionsModeKey:
                                MKLaunchOptionsDirectionsModeDriving]
        
        let mapItems = [userLocationItem, destinationItem] //src to destination
            
        return Button{
            MKMapItem.openMaps(with:mapItems, launchOptions: options)
        } label: {
            Text("Direções")
                .font(.headline)
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.borderedProminent)
        
    }
    
    private var nextButton: some View {
        Button{
            
        } label: {
            Text("Saber mais")
                .font(.headline)
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.bordered)
    }
}
