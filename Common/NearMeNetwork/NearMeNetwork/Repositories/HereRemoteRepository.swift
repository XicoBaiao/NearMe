//
//  HereRemoteRepository.swift
//  NearMeNetwork
//
//  Created by Domingues, Nicolá Silva on 25/07/2022.
//

import Foundation
import NearMeDomain
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
    
    private func urlForService(_ service: Service) -> URL {
        guard let url = URL(string: HereRemoteRepository.baseURL+service.rawValue) else {
            return URL(string: "")!
        }
        return url
    }
    
    public func search(query: String?, categories: [String]) -> AnyPublisher<[Location], Error> {
        //        var request = URLRequest(url: urlForService(.discover), cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: TimeInterval(10000))
        let urlString = "https://discover.search.hereapi.com/v1/discover?at=37.125347,-8.541505&limit=10&q=\(query ?? "")&in=countryCode:PRT&apiKey=kR5mUrSdM_VyC5tqpsJ5a9iAI4fmh8cRrBvVj9H21FQ&lang=pt-PT"
        guard let url = URL(string: urlString) else {
            return Fail(error: HereError.invalidURL).eraseToAnyPublisher()
        }
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
    }
}

