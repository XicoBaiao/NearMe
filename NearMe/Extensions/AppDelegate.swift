//
//  AppDelegate.swift
//  NearMe
//
//  Created by Baiao, Francisco Fonseca on 25/07/2022.
//

import Foundation
import UIKit
import GooglePlaces

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        GMSPlacesClient.provideAPIKey("AIzaSyCkF5B25BUCVbqvQhViWVvAR-MHa6IOobg")
        
        return true
    }
}
