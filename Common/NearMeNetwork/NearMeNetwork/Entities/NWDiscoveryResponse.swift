//
//  NWDiscoveryResponse.swift
//  NearMeNetwork
//
//  Created by Domingues, Nicolá Silva on 26/07/2022.
//

import Foundation

internal struct NWDiscoveryResponse: Codable {
    internal let items: [NWLocation]
    
    internal enum CodingKeys: String, CodingKey {
        case items = "items"
    }
}

internal struct NWLocation: Codable {
    internal let title: String?
    internal let id: String?
    internal let lang: String?
    internal let type: String?
    internal let address: NWAddress?
    internal let position: NWLocationCoordinate
    internal let access: [NWLocationCoordinate]?
    internal let categories: [NWCategory]?
    internal let foodTypes: [NWFoodType]?
    internal let contacts: [NWContact]?
    internal let openingHours: [NWOpeningHour]?
    internal let references: [NWReference]?
    
    internal enum CodingKeys: String, CodingKey {
        case title = "title"
        case id = "id"
        case lang = "language"
        case type = "resultType"
        case address = "address"
        case position = "position"
        case access = "access"
        case categories = "categories"
        case foodTypes = "foodTypes"
        case contacts = "contacts"
        case openingHours = "openingHours"
        case references = "references"
    }
}

internal struct NWAddress: Codable {
    internal let label: String?
    internal let countryCode: String?
    internal let countryName: String?
    internal let stateCode: String?
    internal let state: String?
    internal let county: String?
    internal let city: String?
    internal let district: String?
    internal let street: String?
    internal let postalCode: String?
    internal let houseNumber: String?
    
    internal enum CodingKeys: String, CodingKey {
        case label = "label"
        case countryCode = "countryCode"
        case countryName = "countryName"
        case stateCode = "stateCode"
        case state = "state"
        case county = "county"
        case city = "city"
        case district = "district"
        case street = "street"
        case postalCode = "postalCode"
        case houseNumber = "houseNumber"
    }
}

internal struct NWLocationCoordinate: Codable {
    internal let lat: Double
    internal let lng: Double
    
    internal enum CodingKeys: String, CodingKey {
        case lat = "lat"
        case lng = "lng"
    }
    
}

internal struct NWCategory: Codable {
    internal let id: String?
    internal let name: String?
    internal let primary: Bool?
    
    internal enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case primary = "primary"
    }
}

internal struct NWFoodType: Codable {
    internal let id: String?
    internal let name: String?
    internal let primary: Bool?
    
    internal enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case primary = "primary"
    }
}

internal struct NWContact: Codable {
    internal let phones: [NWPhone]?
    internal let websites: [NWWebsite]?
    internal let email: [NWEmail]?
    
    internal enum CodingKeys: String, CodingKey {
        case phones = "phone"
        case websites = "www"
        case email = "email"
    }
}

internal struct NWPhone: Codable {
    internal let value: String?

    internal enum CodingKeys: String, CodingKey {
        case value = "value"
    }
}

internal struct NWWebsite: Codable {
    internal let value: String?
    internal let categories: [NWCategory]?

    internal enum CodingKeys: String, CodingKey {
        case value = "value"
        case categories = "categories"
    }
}

internal struct NWEmail: Codable {
    internal let value: String?
    internal let categories: [NWCategory]?

    internal enum CodingKeys: String, CodingKey {
        case value = "value"
        case categories = "categories"
    }
}

internal struct NWOpeningHour: Codable {
    internal let categories: [NWCategory]?
    internal let text: [String]?
    internal let isOpen: Bool?
    internal let structured: [NWOpeningHourStruct]?

    internal enum CodingKeys: String, CodingKey {
        case categories = "categories"
        case text = "text"
        case isOpen = "isOpen"
        case structured = "structured"
    }
}

internal struct NWOpeningHourStruct: Codable {
    internal let start: String?
    internal let duration: String?
    internal let recurrence: String?

    internal enum CodingKeys: String, CodingKey {
        case start = "start"
        case duration = "duration"
        case recurrence = "recurrence"
    }
}

internal struct NWReference: Codable {
    internal let supplier: NWSupplier?
    internal let id: String?

    internal enum CodingKeys: String, CodingKey {
        case supplier = "supplier"
        case id = "id"
    }
}

internal struct NWSupplier: Codable {
    internal let id: String?

    internal enum CodingKeys: String, CodingKey {
        case id = "id"
    }
}
