//
//  GeocodingResponse.swift
//  ExploreIt
//
//  Created by Elyan Gutierrez on 8/17/24.
//

import Foundation

struct GeocodingResponse: Codable {
    struct Feature: Codable {
        struct Properties: Codable {
            let place_id: String
        }
        let properties: Properties
    }
    let features: [Feature]
}
