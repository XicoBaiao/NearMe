//
//  HereRepositoryType.swift
//  NearMeDomain
//
//  Created by Domingues, Nicolá Silva on 25/07/2022.
//

import Foundation
import Combine
import CoreLocation

public protocol HereRepositoryType {
    
    func search(query: String?, userLocation: CLLocationCoordinate2D?, categories: [String]) -> AnyPublisher<[Location], Error>
    
}
