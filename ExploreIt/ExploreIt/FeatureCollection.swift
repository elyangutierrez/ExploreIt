//
//  FeatureCollection.swift
//  ExploreIt
//
//  Created by Elyan Gutierrez on 8/17/24.
//

import CoreLocation
import Foundation
import SwiftUI

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
        case accommodation, activity, airport, commercial, catering, education, childcare, entertainment, healthcare
        case heritage, highway, leisure, man_made, natural, national_park, office, parking, pet, power, production
        case railway, rental, service, tourism, religion, camping, amenity, beach, adult, building, ski, sport
        case public_transport, administrative, postal_code, political, low_emission_zone, populated_place
        case dogs, internet_access, wheelchair, access, access_limited, no_access, fee, no_fee, named
    }
    
    enum ColorAssociatedWithMarker: String {
        case accommodation, rental, hotel = ".red"
        case catering, food = ".orange"
        case activity, entertainment, sport, leisure, ski, tourism = ".yellow"
        case healthcare, education, childcare, service = ".green"
        case natural, national_park, heritage, camping, amenity, beach, pet, dogs = ".teal"
        case commercial, office, production, building, power = ".cyan"
        case public_transport, railway, airport, highway, parking, man_made = ".blue"
        case religion, administrative, political = ".indigo"
        case internet_access, wheelchair, access, access_limited, no_access, fee, no_fee, named, low_emission_zone, populated_place, postal_code = ".purple"
        case adult = ".brown"
    }
    
    var getCategoryColor: String {
        switch getCatagory {
        case ColorAssociatedWithMarker.accommodation.rawValue,
            ColorAssociatedWithMarker.rental.rawValue,
            ColorAssociatedWithMarker.hotel.rawValue:
            return ".red"
            
        case ColorAssociatedWithMarker.catering.rawValue,
            ColorAssociatedWithMarker.food.rawValue:
            return ".orange"
            
        case ColorAssociatedWithMarker.activity.rawValue,
            ColorAssociatedWithMarker.entertainment.rawValue,
            ColorAssociatedWithMarker.sport.rawValue,
            ColorAssociatedWithMarker.leisure.rawValue,
            ColorAssociatedWithMarker.ski.rawValue,
            ColorAssociatedWithMarker.tourism.rawValue:
            return ".yellow"
            
        case ColorAssociatedWithMarker.healthcare.rawValue,
            ColorAssociatedWithMarker.education.rawValue,
            ColorAssociatedWithMarker.childcare.rawValue,
            ColorAssociatedWithMarker.service.rawValue:
            return ".green"
            
        case ColorAssociatedWithMarker.natural.rawValue,
            ColorAssociatedWithMarker.national_park.rawValue,
            ColorAssociatedWithMarker.heritage.rawValue,
            ColorAssociatedWithMarker.camping.rawValue,
            ColorAssociatedWithMarker.amenity.rawValue,
            ColorAssociatedWithMarker.beach.rawValue,
            ColorAssociatedWithMarker.pet.rawValue,
            ColorAssociatedWithMarker.dogs.rawValue:
            return ".teal"
            
        case ColorAssociatedWithMarker.commercial.rawValue,
            ColorAssociatedWithMarker.office.rawValue,
            ColorAssociatedWithMarker.production.rawValue,
            ColorAssociatedWithMarker.building.rawValue,
            ColorAssociatedWithMarker.power.rawValue:
            return ".cyan"
            
        case ColorAssociatedWithMarker.public_transport.rawValue,
            ColorAssociatedWithMarker.railway.rawValue,
            ColorAssociatedWithMarker.airport.rawValue,
            ColorAssociatedWithMarker.highway.rawValue,
            ColorAssociatedWithMarker.parking.rawValue,
            ColorAssociatedWithMarker.man_made.rawValue:
            return ".blue"
            
        case ColorAssociatedWithMarker.religion.rawValue,
            ColorAssociatedWithMarker.administrative.rawValue,
            ColorAssociatedWithMarker.political.rawValue:
            return ".indigo"
            
        case ColorAssociatedWithMarker.internet_access.rawValue,
            ColorAssociatedWithMarker.wheelchair.rawValue,
            ColorAssociatedWithMarker.access.rawValue,
            ColorAssociatedWithMarker.access_limited.rawValue,
            ColorAssociatedWithMarker.no_access.rawValue,
            ColorAssociatedWithMarker.fee.rawValue,
            ColorAssociatedWithMarker.no_fee.rawValue,
            ColorAssociatedWithMarker.named.rawValue,
            ColorAssociatedWithMarker.low_emission_zone.rawValue,
            ColorAssociatedWithMarker.populated_place.rawValue,
            ColorAssociatedWithMarker.postal_code.rawValue:
            return ".purple"
            
        case ColorAssociatedWithMarker.adult.rawValue:
            return ".brown"
        default:
            return ""
        }
    }
    
    var getCatagory: String {
        var output = ""
        output = categories.first ?? ""
        
        print("The first output is: \(output)")
        
        switch output {
        case AvaliableCategories.accommodation.rawValue,
             AvaliableCategories.activity.rawValue,
             AvaliableCategories.airport.rawValue,
             AvaliableCategories.commercial.rawValue,
             AvaliableCategories.catering.rawValue,
             AvaliableCategories.education.rawValue,
             AvaliableCategories.childcare.rawValue,
             AvaliableCategories.entertainment.rawValue,
             AvaliableCategories.healthcare.rawValue,
             AvaliableCategories.heritage.rawValue,
             AvaliableCategories.highway.rawValue,
             AvaliableCategories.leisure.rawValue,
             AvaliableCategories.man_made.rawValue,
             AvaliableCategories.natural.rawValue,
             AvaliableCategories.national_park.rawValue,
             AvaliableCategories.office.rawValue,
             AvaliableCategories.parking.rawValue,
             AvaliableCategories.pet.rawValue,
             AvaliableCategories.power.rawValue,
             AvaliableCategories.production.rawValue,
             AvaliableCategories.railway.rawValue,
             AvaliableCategories.rental.rawValue,
             AvaliableCategories.service.rawValue,
             AvaliableCategories.tourism.rawValue,
             AvaliableCategories.religion.rawValue,
             AvaliableCategories.camping.rawValue,
             AvaliableCategories.amenity.rawValue,
             AvaliableCategories.beach.rawValue,
             AvaliableCategories.adult.rawValue,
             AvaliableCategories.building.rawValue,
             AvaliableCategories.ski.rawValue,
             AvaliableCategories.sport.rawValue,
             AvaliableCategories.public_transport.rawValue,
             AvaliableCategories.administrative.rawValue,
             AvaliableCategories.postal_code.rawValue,
             AvaliableCategories.political.rawValue,
             AvaliableCategories.low_emission_zone.rawValue,
             AvaliableCategories.populated_place.rawValue,
             AvaliableCategories.dogs.rawValue,
             AvaliableCategories.internet_access.rawValue,
             AvaliableCategories.wheelchair.rawValue,
             AvaliableCategories.access.rawValue,
             AvaliableCategories.access_limited.rawValue,
             AvaliableCategories.no_access.rawValue,
             AvaliableCategories.fee.rawValue,
             AvaliableCategories.no_fee.rawValue,
             AvaliableCategories.named.rawValue:
            return output
        default:
            return output
        }
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
