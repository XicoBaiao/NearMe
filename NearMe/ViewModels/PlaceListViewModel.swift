//
//  PlaceListViewModel.swift
//  NearMe
//
//  Created by Baiao, Francisco Fonseca on 20/07/2022.
//

import Foundation
import Combine
import MapKit
import NearMeDomain
import NearMeNetwork

class PlaceListViewModel: ObservableObject {
    
    private let locationManager: LocationManager
    var cancellable: AnyCancellable?
    @Published var currentLocation: CLLocationCoordinate2D?
    @Published var locations: [LocationListItemViewModel] = []
    
    private var cancellables = Set<AnyCancellable>()
    private var hereRepository: HereRepositoryType
    
    init(hereRepository: HereRepositoryType = HereRemoteRepository()) {
        locationManager = LocationManager()
        self.hereRepository = hereRepository
        cancellable = locationManager.$location.sink { (location) in
            if let location = location {
                DispatchQueue.main.async {
                    self.currentLocation = location.coordinate
                    self.locationManager.stopUpdates()
                }
            }
        }
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdates()
    }
    
//    func searchLandmarks(searchTerm: String) {
//
//        let request = MKLocalSearch.Request()
//        request.naturalLanguageQuery = searchTerm
//
//        let search = MKLocalSearch(request: request)
//        search.start { (response, error) in
//            if let error = error {
//                print(error)
//            } else if let response = response {
//                let mapItems = response.mapItems
//                self.locations = mapItems.map {
//                    return LandmarkViewModel(placemark: $0.placemark)
//                }
//            }
//        }
//
//    }
    
    func fetchLandmarks(query: String?) {
        hereRepository.search(query: query, categories: [])
            .receive(on: DispatchQueue.main)
            .sink {
                switch $0 {
                case .failure(let error):
                    print(error)
                case .finished:
                    print("finished")
                }
            } receiveValue: { locations in
                self.locations = locations.map { LocationListItemViewModel(location: $0) }
            }
            .store(in: &cancellables)

    }
    
}
