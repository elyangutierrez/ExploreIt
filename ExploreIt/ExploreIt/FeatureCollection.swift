//
//  FeatureCollection.swift
//  ExploreIt
//
//  Created by Elyan Gutierrez on 8/17/24.
//

import CoreLocation
import Foundation

struct FeatureCollection: Codable, Hashable  {
    let type: String
    let features: [Feature]
}

struct Feature: Codable, Hashable {
    let type: String
    let properties: Properties
    let geometry: Geometry
}

struct Properties: Codable, Hashable  {
    let name: String
    let country: String
    let countryCode: String
    let state: String
    let county: String?
    let city: String
    let postcode: String
    let lon: Double
    let lat: Double
    let stateCode: String
    let formatted: String
    let addressLine1: String
    let addressLine2: String
    let categories: [String]
    let details: [String]
    let datasource: Datasource
    let website: String?
    let ele: Int?
    let contact: Contact?
    let wikiAndMedia: WikiAndMedia?
    let placeID: String
    let building: Building?
    let brand: String?
    let brandDetails: BrandDetails?
    let openingHours: String?
    let artwork: Artwork?

    enum CodingKeys: String, CodingKey {
        case name, country, state, county, city, postcode, lon, lat, formatted, website, ele, contact, building, brand, openingHours, artwork
        case countryCode = "country_code"
        case stateCode = "state_code"
        case addressLine1 = "address_line1"
        case addressLine2 = "address_line2"
        case categories, details, datasource, wikiAndMedia = "wiki_and_media", placeID = "place_id", brandDetails = "brand_details"
    }
}

struct Datasource: Codable, Hashable  {
    let sourcename: String
    let attribution: String
    let license: String
    let url: String
    let raw: Raw
}

struct Raw: Codable, Hashable  {
    let ele: Int?
    let name: String
    let phone: String?
    let osmID: Int
    let leisure: String?
    let tourism: String?
    let website: String?
    let osmType: String
    let wikidata: String?
    let addrCity: String?
    let wikipedia: String?
    let addrState: String?
    let addrStreet: String?
    let addrPostcode: Int?
    let addrHousenumber: Int?
    let sport: String?
    let brand: String?
    let brandWikidata: String?
    let openingHours: String?
    let layer: Int?
    let amenity: String?
    let building: String?
    let building1: String?

    enum CodingKeys: String, CodingKey {
        case ele, name, phone, leisure, tourism, website, wikidata, wikipedia, sport, brand, openingHours, layer, amenity, building
        case osmID = "osm_id"
        case osmType = "osm_type"
        case addrCity = "addr:city"
        case addrState = "addr:state"
        case addrStreet = "addr:street"
        case addrPostcode = "addr:postcode"
        case addrHousenumber = "addr:housenumber"
        case brandWikidata = "brand:wikidata"
        case building1 = "building_1"
    }
}

struct Geometry: Codable, Hashable  {
    let type: String
    let coordinates: [Double]
    
    var getCoordinates: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: coordinates[1], longitude: coordinates[0])
    }
}

struct Contact: Codable, Hashable  {
    let phone: String
}

struct WikiAndMedia: Codable, Hashable  {
    let wikidata: String?
    let wikipedia: String?
    let image: String?
}

struct Building: Codable, Hashable  {
    let type: String?
}

struct BrandDetails: Codable, Hashable  {
    let wikidata: String?
}

struct Artwork: Codable, Hashable  {
    let artistName: String?
    let artworkType: String?

    enum CodingKeys: String, CodingKey {
        case artistName = "artist_name"
        case artworkType = "artwork_type"
    }
}
