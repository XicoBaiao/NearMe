//
//  Environment.swift
//  NearMe
//
//  Created by Baiao, Francisco Fonseca on 23/08/2022.
//

import Foundation

public enum Environment {
    
    enum Keys {
        static let googleApiKey = "GOOGLE_API_KEY"
    }
    
    private static let infoDictionary: [String:Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("plist file not found")
        }
        return dict
    }()
    
    static let googleApiKey: String = {
        guard let apiKeyString = Environment.infoDictionary[Keys.googleApiKey] as? String else {
                fatalError("GOOGLE API KEY not set in plist")
        }
        return apiKeyString
    }()
}
