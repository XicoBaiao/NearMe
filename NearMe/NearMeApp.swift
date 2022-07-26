//
//  NearMeApp.swift
//  NearMe
//
//  Created by Baiao, Francisco Fonseca on 13/07/2022.
//

import SwiftUI
import GoogleMaps
import GooglePlaces

@main
struct NearMeApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init() {
        GMSServices.provideAPIKey("AIzaSyCkF5B25BUCVbqvQhViWVvAR-MHa6IOobg")
        
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
