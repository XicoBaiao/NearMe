//
//  LandmarkListView.swift
//  NearMe
//
//  Created by Baiao, Francisco Fonseca on 20/07/2022.
//

import SwiftUI

struct LandmarkListView: View {
    
    let locations: [LocationListItemViewModel]
    
    var body: some View {
        List(locations, id: \.id) { location in
            VStack(alignment: .leading, spacing: 10) {
                Text(location.name)
                    .font(.headline)
                if let title = location.title {
                    Text(title)
                }
            }
        }.listStyle(.plain)
    }
}

