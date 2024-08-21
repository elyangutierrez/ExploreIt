//
//  CityAutocomplete.swift
//  ExploreIt
//
//  Created by Elyan Gutierrez on 8/20/24.
//

import Foundation

struct CityAutocomplete: Codable, Identifiable, Hashable {
    let id = UUID()
    let city: String?
    let state: String
    let country: String
    
    enum CodingKeys: String, CodingKey {
        case city, state, country
    }
}

struct Results: Codable {
    let results: [CityAutocomplete]
}
