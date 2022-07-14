//
//  NearMeMapCoordinator.swift
//  NearMe
//
//  Created by Baiao, Francisco Fonseca on 14/07/2022.
//

import Foundation
import MapKit

final class NearMeMapCoordinator: NSObject, MKMapViewDelegate {
    
    var control: NearMeMapView
    
    init(_ control: NearMeMapView) {
        self.control = control
    }
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        if let annotationView = views.first {
            if let annotation = annotationView.annotation {
                if annotation is MKUserLocation {
                    
                    let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                    mapView.setRegion(region, animated: true)
                }
            }
        }
    }
    
}

