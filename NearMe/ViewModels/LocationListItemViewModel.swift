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
    
}
