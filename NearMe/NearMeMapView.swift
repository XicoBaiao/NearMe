//
//  NearMeMapView.swift
//  NearMe
//
//  Created by Baiao, Francisco Fonseca on 14/07/2022.
//

import Foundation
import UIKit
import MapKit
import SwiftUI

struct NearMeMapView: UIViewRepresentable {
    
    let landmarks: [Landmark]
    
    func makeCoordinator() -> NearMeMapCoordinator {
        NearMeMapCoordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let map = MKMapView()
        map.showsUserLocation = true
        map.delegate = context.coordinator
        return map
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<NearMeMapView>) {
        updateAnnotations(from: uiView)
    }
    
    private func updateAnnotations(from mapView: MKMapView) {
        
        mapView.removeAnnotations(mapView.annotations)
        let annotations = self.landmarks.map(LandmarkAnnotation.init)
        mapView.addAnnotations(annotations)
    }
    
}
