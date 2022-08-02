//
//  Location.swift
//  NearMeDomain
//
//  Created by Domingues, Nicolá Silva on 26/07/2022.
//

import Foundation

public struct Location {
    public let title: String?
    public let id: String?
    public let lang: String?
    public let type: String?
    public let address: Address?
    public let position: LocationCoordinate
    public let access: [LocationCoordinate]
    public let categories: [LocationCategory]
    public let foodTypes: [FoodType]
    public let contacts: [Contact]
    public let openingHours: [OpeningHour]
    public let references: [Reference]
    
    public init(title: String?, id: String?, lang: String?,
                type: String?, address: Address?, position: LocationCoordinate,
                access: [LocationCoordinate]?, categories: [LocationCategory]?, foodTypes: [FoodType]?,
                contacts: [Contact]?, openingHours: [OpeningHour]?, references: [Reference]?) {
        
        self.title = title
        self.id = id
        self.lang = lang
        self.type = type
        self.address = address
        self.position = position
        self.access = access ?? []
        self.categories = categories ?? []
        self.foodTypes = foodTypes ?? []
        self.contacts = contacts ?? []
        self.openingHours = openingHours ?? []
        self.references = references ?? []
    }
}

public struct Address: Codable {
    public let label: String?
    public let countryCode: String?
    public let countryName: String?
    public let stateCode: String?
    public let state: String?
    public let county: String?
    public let city: String?
    public let district: String?
    public let street: String?
    public let postalCode: String?
    public let houseNumber: String?
    
    public init(label: String?, countryCode: String?, countryName: String?,
                stateCode: String?, state: String?, county: String?, city: String?,
                district: String?, street: String?, postalCode: String?, houseNumber: String?) {
        self.label = label
        self.countryCode = countryCode
        self.countryName = countryName
        self.stateCode = stateCode
        self.state = state
        self.county = county
        self.city = city
        self.district = district
        self.street = street
        self.postalCode = postalCode
        self.houseNumber = houseNumber
    }
    
}

public struct LocationCoordinate: Codable {
    public let lat: Double
    public let lng: Double
    
    public init(lat: Double, lng: Double) {
        self.lat = lat
        self.lng = lng
    }

}

public struct LocationCategory: Codable {
    public let id: String?
    public let name: String?
    public let primary: Bool
    
    public init(id: String?, name: String?, primary: Bool?) {
        self.id = id
        self.name = name
        self.primary = primary ?? false
    }

}

public struct FoodType: Codable {
    public let id: String?
    public let name: String?
    public let primary: Bool
    
    public init(id: String?, name: String?, primary: Bool?) {
        self.id = id
        self.name = name
        self.primary = primary ?? false
    }
    
}

public struct Contact: Codable {
    public let phones: [Phone]
    public let websites: [Website]
    public let email: [Email]
    
    public init(phones: [Phone]?, websites: [Website]?, email: [Email]?) {
        self.phones = phones ?? []
        self.websites = websites ?? []
        self.email = email ?? []
    }
    
}

public struct Phone: Codable {
    public let value: String?
    
    public init(value: String?) {
        self.value = value
    }

}

public struct Website: Codable {
    public let value: String?
    public let categories: [LocationCategory]
    
    public init(value: String?, categories: [LocationCategory]?) {
        self.value = value
        self.categories = categories ?? []
    }

}

public struct Email: Codable {
    public let value: String?
    public let categories: [LocationCategory]
    
    public init(value: String?, categories: [LocationCategory]?) {
        self.value = value
        self.categories = categories ?? []
    }

}

public struct OpeningHour: Codable {
    public let categories: [LocationCategory]
    public let text: [String]
    public let isOpen: Bool
    public let structured: [OpeningHourStruct]
    
    public init(categories: [LocationCategory]?, text: [String]?, isOpen: Bool?, structured: [OpeningHourStruct]?) {
        self.categories = categories ?? []
        self.text = text ?? []
        self.isOpen = isOpen ?? false
        self.structured = structured ?? []
    }

}

public struct OpeningHourStruct: Codable {
    public let start: String?
    public let duration: String?
    public let recurrence: String?
    
    public init(start: String?, duration: String?, recurrence: String?) {
        self.start = start
        self.duration = duration
        self.recurrence = recurrence
    }

}

public struct Reference: Codable {
    public let supplier: Supplier?
    public let id: String?
    
    public init(supplier: Supplier?, id: String?) {
        self.supplier = supplier
        self.id = id
    }

}

public struct Supplier: Codable {
    public let id: String?
    
    public init(id: String?) {
        self.id = id
    }
}
