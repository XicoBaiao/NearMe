//
//  HereRemoteRepository.swift
//  NearMeNetwork
//
//  Created by Domingues, Nicolá Silva on 25/07/2022.
//

import Foundation
import NearMeDomain
import CoreLocation
import Combine

public class HereRemoteRepository: HereRepositoryType {
    
    public init() {
        
    }
    
    static var baseURL = "https://discover.search.hereapi.com"
    
    enum Service: String {
        case discover = "/v1/discover"
    }
    
    enum HereError: Error {
        case invalidURL
    }
    
    private func urlForService(_ service: Service,
                               query: String?,
                               userLocation: CLLocationCoordinate2D?,
                               categories: [String] = [],
                               limit: Int = 50) throws -> URL {
        let formattedQuery = query?.replacingOccurrences(of: " ", with: "+")
        let urlString = "\(HereRemoteRepository.baseURL)\(service.rawValue)?at=\(userLocation?.latitude ?? 0.0),\(userLocation?.longitude ?? 0.0)&q=\(formattedQuery ?? "")&lang=pt-PT&in=countryCode:PRT&limit=\(limit)&apiKey=kR5mUrSdM_VyC5tqpsJ5a9iAI4fmh8cRrBvVj9H21FQ"
        guard let url = URL(string: urlString) else {
            throw HereError.invalidURL
        }
        return url
    }
    
    public func search(query: String?, userLocation: CLLocationCoordinate2D?, categories: [String]) -> AnyPublisher<[Location], Error> {
        do {
            let url = try urlForService(.discover, query: query, userLocation: userLocation)
            return URLSession.shared.dataTaskPublisher(for: url)
                .tryMap() { element -> Data in
                    guard let httpResponse = element.response as? HTTPURLResponse,
                          httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                    }
                    return element.data
                }
                .decode(type: NWDiscoveryResponse.self, decoder: JSONDecoder())
                .compactMap({ $0.asLocations() })
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
       
    }
}

