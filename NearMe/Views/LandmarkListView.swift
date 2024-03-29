//
//  LandmarkListView.swift
//  NearMe
//
//  Created by Baiao, Francisco Fonseca on 20/07/2022.
//

import SwiftUI

struct LandmarkListView: View {
    
    let landmarks: [LandmarkViewModel]
    var locationManager: LocationManager
    @Binding var displayType: DisplayType
    @Binding var selectedLandmark: LandmarkViewModel
    @Binding var landmarkIsSelected: Bool
    
    var body: some View {
        List(landmarks, id: \.id) { landmark in
            HStack(spacing: 10) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(landmark.name)
                        .font(.headline)
                    Text(landmark.title)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text(landmark.distanceToUserInKm(locationManager: locationManager))
                        .font(.body)
                        .lineLimit(1)
                        .minimumScaleFactor(0.01)
                }.frame(width: 50)
            }.onTapGesture {
                displayType = .map
                selectedLandmark = landmark
                landmarkIsSelected = true
                GooglePlacesManager.shared.findPlacePhoto(place: selectedLandmark)
            }
        }.listStyle(.plain)
    }
}

