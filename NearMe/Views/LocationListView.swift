//
//  LocationListView.swift
//  NearMe
//
//  Created by Baiao, Francisco Fonseca on 20/07/2022.
//

import SwiftUI

struct LocationListView: View {
    
    let locations: [LocationListItemViewModel]
    var locationManager: LocationManager
    @Binding var displayType: DisplayType
    @Binding var selectedLocation: LocationListItemViewModel
    @Binding var locationIsSelected: Bool
    
    var body: some View {
        List(locations, id: \.id) { location in
            HStack(spacing: 10) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(location.name)
                        .font(.headline)
                    Text(location.title ?? "")
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text(location.distanceToUserInKm(locationManager: locationManager))
                        .font(.body)
                        .lineLimit(1)
                        .minimumScaleFactor(0.01)
                }.frame(width: 50)
            }.onTapGesture {
                displayType = .map
                selectedLocation = location
                locationIsSelected = true
                GooglePlacesManager.shared.findPlacePhoto(place: selectedLocation)
            }
        }.listStyle(.plain)
    }
}

