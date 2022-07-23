//
//  LandmarkViewModel.swift
//  NearMe
//
//  Created by Baiao, Francisco Fonseca on 20/07/2022.
//

import Foundation
import MapKit

struct LandmarkViewModel: Identifiable {
    
    let placemark: MKPlacemark
    
    
    let id = UUID()
    
    var name: String {
        placemark.name ?? ""
    }
    
    var title: String {
        placemark.title ?? ""
    }
    
    var coordinate: CLLocationCoordinate2D {
        placemark.coordinate
    }
    
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
