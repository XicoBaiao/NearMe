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
    
}
