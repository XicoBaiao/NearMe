//
//  HereRepositoryType.swift
//  NearMeDomain
//
//  Created by Domingues, Nicolá Silva on 25/07/2022.
//

import Foundation
import Combine

public protocol HereRepositoryType {
    
    func search(query: String?, categories: [String]) -> AnyPublisher<[Location], Error>
    
}
