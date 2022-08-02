//
//  SplashScreenView.swift
//  NearMe
//
//  Created by Baiao, Francisco Fonseca on 28/07/2022.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var size = 0.4
    @State private var opacity = 0.5
    
    var body: some View {
        
        if isActive {
            HomeScreen()
        } else {
            VStack{
                VStack {
                    Image("SplashImage")
                        .resizable()
                        .scaledToFit()
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 4)) {
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                }
                
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                    withAnimation {
                        self.isActive = true
                    }
                    
                }
            }
        }
        
        
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
