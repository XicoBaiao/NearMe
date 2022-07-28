//
//  HomeScreenImageView.swift
//  NearMe
//
//  Created by Baiao, Francisco Fonseca on 28/07/2022.
//

import SwiftUI

struct HomeScreenImageView: View {
    
    let coverImages: [CoverImage] = Bundle.main.decode("covers.json")
    
    private let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    
    @State private var currentIndex = 0
    
    var body: some View {
        TabView(selection: $currentIndex) {
                ForEach(coverImages) { item in
                    Image(item.name)
                        .resizable()
                        .scaledToFill()
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .onReceive(timer, perform: { _ in
                withAnimation {
                    currentIndex = currentIndex < coverImages.count ? currentIndex + 1 : 0
                }
            })
    }
}

struct HomeScreenImageView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenImageView()
            .previewLayout(.fixed(width: 400, height: 300))
    }
}
