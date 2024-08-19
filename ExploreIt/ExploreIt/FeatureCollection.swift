//
//  FeatureCollection.swift
//  ExploreIt
//
//  Created by Elyan Gutierrez on 8/17/24.
//

import CoreLocation
import Foundation

struct FeatureCollection: Codable {
    let type: String
    let features: [Feature]
    
    enum CodingKeys: String, CodingKey {
        case type
        case features
    }
}

struct Feature: Codable, Hashable {
    let type: String
    let properties: Properties
    let geometry: Geometry
    
    enum CodingKeys: String, CodingKey {
        case type
        case properties
        case geometry
    }
    
}

struct Properties: Codable, Hashable  {
    let name: String?
    let country: String?
    let countryCode: String?
    let state: String?
    let county: String?
    let city: String?
    let postcode: String?
    let lon: Double
    let lat: Double
    let stateCode: String?
    let formatted: String?
    let addressLine1: String?
    let addressLine2: String?
    let categories: [String]
    let details: [String]
    let datasource: Datasource?
    let website: String?
    let ele: Int?
    let wikiAndMedia: WikiAndMedia?
    let placeID: String
    let brand: String?
    let openingHours: String?

    enum CodingKeys: String, CodingKey {
        case name, country, state, county, city, lon, lat, formatted, website, ele, brand, openingHours
        case countryCode = "country_code"
        case stateCode = "state_code"
        case addressLine1 = "address_line1"
        case addressLine2 = "address_line2"
        case categories, details, datasource, wikiAndMedia = "wiki_and_media", placeID = "place_id"
        case postcode
    }
    
    enum AvaliableCategories: String {
        case 
    }
}

struct Datasource: Codable, Hashable  {
    let sourcename: String
    let attribution: String
    let license: String
    let url: String
    let raw: Raw
    
    enum CodingKeys: String, CodingKey {
        case sourcename
        case attribution
        case license
        case url
        case raw
    }
}

struct Raw: Codable, Hashable  {
    let ele: Int?
    let name: String?
    let osmID: Int?
    let leisure: String?
    let tourism: String?
    let website: String?
    let osmType: String?
    let wikidata: String?
    let wikipedia: String?
    let sport: String?
    let brand: String?
    let brandWikidata: String?
    let openingHours: String?
    let layer: Int?
    let amenity: String?

    enum CodingKeys: String, CodingKey {
        case ele, name, leisure, tourism, website, wikidata, wikipedia, sport, brand, openingHours, layer, amenity
        case osmID = "osm_id"
        case osmType = "osm_type"
        case brandWikidata = "brand:wikidata"
    }
}

struct Geometry: Codable, Hashable  {
    let type: String
    let coordinates: [Double]
    
    var getCoordinates: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: coordinates[1], longitude: coordinates[0])
    }
    
    enum CodingKeys: String, CodingKey {
        case type
        case coordinates
    }
}

struct WikiAndMedia: Codable, Hashable  {
    let wikidata: String?
    let wikipedia: String?
    let image: String?
    
    enum CodingKeys: String, CodingKey {
        case wikidata
        case wikipedia
        case image
    }
}
