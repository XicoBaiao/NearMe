//
//  LandmarkAnnotation.swift
//  NearMe
//
//  Created by Baiao, Francisco Fonseca on 14/07/2022.
//

import Foundation
import MapKit

final class LandmarkAnnotation: NSObject, MKAnnotation {
    
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(landmark: Landmark) {
        self.title = landmark.name
        self.coordinate = landmark.coordinate
    }
    
}


