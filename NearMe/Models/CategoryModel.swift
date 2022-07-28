//
//  CategoryModel.swift
//  NearMe
//
//  Created by Baiao, Francisco Fonseca on 28/07/2022.
//

import SwiftUI

struct Category: Codable, Identifiable {
    let id: String
    let name : String
    let headline: String
    let image: String
}
