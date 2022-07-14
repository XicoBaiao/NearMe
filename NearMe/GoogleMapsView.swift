//
//  GoogleMapsView.swift
//  NearMe
//
//  Created by Baiao, Francisco Fonseca on 14/07/2022.
//

import SwiftUI
import GoogleMaps

struct GoogleMapsView: View {
    
    @State private var places = [Place(name: "Indian",
                                       latLng: CLLocationCoordinate2D(latitude: 23,
                                                                                      longitude: -6),
                                       address: "Rua das Flores",
                                       rating: 5)]
    
    var body: some View {
        VStack {
            Text("Near Me App")
                .font(.title)
            GoogleMapView(places: $places)
                .ignoresSafeArea()
        }
        
    }
}

struct GoogleMapView: UIViewRepresentable {
    
    typealias UIViewType = GMSMapView
    
    @Binding var places: [Place]
    
    func makeUIView(context: Context) -> GMSMapView {
        let camera = GMSCameraPosition.camera(withLatitude: 37.12534738530079, longitude: -8.541505164842189, zoom: 15.0)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        return mapView
    }
    
    func updateUIView(_ uiView: GMSMapView, context: Context) {
        context.coordinator.addMarkers(mapView: uiView)
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(places)
    }

}

class Coordinator: NSObject {
    
    private let places: [Place]
    
    init(_ places: [Place]) {
        self.places = places
    }
    
    func addMarkers(mapView: GMSMapView) {
        places.forEach { place in
            let marker = GMSMarker()
            marker.position = place.latLng
            marker.title = place.name
            marker.snippet = place.address
            marker.map = mapView
        }
    }
    
}

struct Place {
    let name: String
    let latLng: CLLocationCoordinate2D
    let address: String
    let rating: Float
}

struct GoogleMapsView_Previews: PreviewProvider {
    static var previews: some View {
        GoogleMapsView()
    }
}
