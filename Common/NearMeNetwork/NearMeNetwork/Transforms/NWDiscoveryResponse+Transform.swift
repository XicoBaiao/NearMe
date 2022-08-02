//
//  NWDiscoveryResponse+Transform.swift
//  NearMeNetwork
//
//  Created by Domingues, Nicolá Silva on 26/07/2022.
//

import NearMeDomain

extension NWDiscoveryResponse {
    func asLocations() -> [Location] {
        return self.items.compactMap { $0.asLocation() }
    }
}

extension NWLocation {
    func asLocation() -> Location {
        return Location(title: self.title, id: self.id, lang: self.lang, type: self.type,
                        address: self.address?.asAddress(), position: self.position.asLocationCoordinate(), access: self.access?.asLocationCoordinateArray(), categories: self.categories?.asCategoriesArray(), foodTypes: self.foodTypes?.asFoodTypesArray(), contacts: self.contacts?.asContactsArray(), openingHours: self.openingHours?.asOpeningHoursArray(), references: self.references?.asReferencesArray())
    }
}

extension NWAddress {
    func asAddress() -> Address {
        return Address(label: self.label, countryCode: self.countryCode, countryName: self.countryName,
                       stateCode: self.stateCode, state: self.state, county: self.county, city: self.city,
                       district: self.district, street: self.street,
                       postalCode: self.postalCode, houseNumber: self.houseNumber)
    }
}

extension Sequence where Element == NWLocationCoordinate {
    func asLocationCoordinateArray() -> [LocationCoordinate] {
        return self.map { $0.asLocationCoordinate() }
    }
}

extension NWLocationCoordinate {
    func asLocationCoordinate() -> LocationCoordinate {
        return LocationCoordinate(lat: self.lat, lng: self.lng)
    }
}

extension Sequence where Element == NWCategory {
    func asCategoriesArray() -> [LocationCategory] {
        return self.map { $0.asCategory() }
    }
}

extension NWCategory {
    func asCategory() -> LocationCategory {
        return LocationCategory(id: self.id, name: self.name, primary: self.primary)
    }
}

extension Sequence where Element == NWFoodType {
    func asFoodTypesArray() -> [FoodType] {
        return self.map { $0.asFoodType() }
    }
}

extension NWFoodType {
    func asFoodType() -> FoodType {
        return FoodType(id: self.id, name: self.name, primary: self.primary)
    }
}

extension Sequence where Element == NWContact {
    func asContactsArray() -> [Contact] {
        return self.map { $0.asContact() }
    }
}

extension NWContact {
    func asContact() -> Contact {
        return Contact(phones: self.phones?.asPhonesArray(),
                       websites: self.websites?.asWebsitesArray(),
                       email: self.email?.asEmailsArray())
    }
}

extension Sequence where Element == NWPhone {
    func asPhonesArray() -> [Phone] {
        return self.map { Phone(value: $0.value) }
    }
}

extension Sequence where Element == NWWebsite {
    func asWebsitesArray() -> [Website] {
        return self.map { Website(value: $0.value,
                                  categories: $0.categories?.asCategoriesArray()) }
    }
}

extension Sequence where Element == NWEmail {
    func asEmailsArray() -> [Email] {
        return self.map { Email(value: $0.value,
                                categories: $0.categories?.asCategoriesArray()) }
    }
}

extension Sequence where Element == NWOpeningHour {
    func asOpeningHoursArray() -> [OpeningHour] {
        return self.map { OpeningHour(categories: $0.categories?.asCategoriesArray(),
                                      text: $0.text, isOpen: $0.isOpen, structured: $0.structured?.asOpeningHourStructArray()) }
    }
}

extension Sequence where Element == NWOpeningHourStruct {
    func asOpeningHourStructArray() -> [OpeningHourStruct] {
        return self.map { OpeningHourStruct(start: $0.start, duration: $0.duration, recurrence: $0.recurrence) }
    }
}

extension Sequence where Element == NWReference {
    func asReferencesArray() -> [Reference] {
        return self.map { Reference(supplier: $0.supplier?.asSupplier(), id: $0.id) }
    }
}

extension NWSupplier {
    func asSupplier() -> Supplier {
        return Supplier(id: self.id)
    }
}
