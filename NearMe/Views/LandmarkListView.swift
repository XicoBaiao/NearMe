//
//  LandmarkListView.swift
//  NearMe
//
//  Created by Baiao, Francisco Fonseca on 20/07/2022.
//

import SwiftUI

struct LandmarkListView: View {
    
    let landmarks: [LandmarkViewModel]
    
    var body: some View {
        List(landmarks, id: \.id) { landmark in
            VStack(alignment: .leading, spacing: 10) {
                Text(landmark.name)
                    .font(.headline)
                Text(landmark.title)
            }
        }.listStyle(.plain)
    }
}

