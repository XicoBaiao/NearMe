//
//  PlaceListView.swift
//  NearMe
//
//  Created by Baiao, Francisco Fonseca on 19/07/2022.
//

import SwiftUI
import MapKit

struct PlaceListView: View {
    
    let landmarks: [Landmark]
    var onTap: () -> ()
    
    var body: some View {
        VStack(spacing: 0.0) {
            HStack {
                EmptyView()
            }.frame(width: UIScreen.main.bounds.size.width, height: 60)
                .background(Color.blue)
                .gesture(TapGesture()
                    .onEnded(self.onTap)
                )
            List(self.landmarks, id: \.id) { landmark in
                Text(landmark.name)
            }
            .listStyle(.plain)
            .animation(nil)
        }.cornerRadius(16)
    }
}

struct PlaceListView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceListView(landmarks: [Landmark(placemark: MKPlacemark())], onTap: {})
    }
}
