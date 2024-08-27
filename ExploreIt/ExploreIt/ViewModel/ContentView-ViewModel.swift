//
//  ContentView - ViewModel.swift
//  ExploreIt
//
//  Created by Elyan Gutierrez on 8/20/24.
//

import CoreLocation
import Foundation
import MapKit
import Observation
import _MapKit_SwiftUI

@Observable
class ViewModel {
    
    var locationManager = LocationManager()
    var searchText = ""
    var landmarks = [Landmark]()
    var featureCollection = [Feature]()
    var autocompletionResults = [CityAutocomplete]()
    var mapCameraPosition: MapCameraPosition = .automatic
    var placeID = ""
    var noResultsFound = false
    var resultsAreAvaliable = false
    var searchWasSubmitted = false
    var currentAttraction: Feature? = nil
    var autocompletionSearchText = ""
    var autoCompletionTouched = false
    var resultsAreLoaded = false
    var runQueryTask = false
    
    var destinationsLat = 0.0
    var destinationsLon = 0.0
    var distanceResult = 0.0
    var readyToCalculateDistance = false
    
    
    let unitedStatesRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 105.7129, longitude: -95), // Example: San Francisco
        span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
    )
    
    func returnSearchResults() async {
        
        // Gets the initial position of what city you want to go to
        
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = autocompletionSearchText
        
        print("Getting search results text: \(autocompletionSearchText)")
        
        let search = MKLocalSearch(request: searchRequest)
        
        do {
            let response = try await search.start()
            landmarks = response.mapItems.map { mapItem in
                Landmark(placement: mapItem.placemark)
            }
            
            if let updatedRegion = response.mapItems.first {
                mapCameraPosition = .region(MKCoordinateRegion(center: updatedRegion.placemark.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)))
            }
            
            if let getLatitudeOfDestination = response.mapItems.first {
                destinationsLat = getLatitudeOfDestination.placemark.coordinate.latitude
                print("Destinations Latitude: \(destinationsLat)")
            }
            
            if let getLonOfDestination = response.mapItems.first {
                destinationsLon = getLonOfDestination.placemark.coordinate.longitude
                print("Destinations Longitude: \(destinationsLon)")
            }
            
            distanceResult = haversineDistance(lat1: locationManager.location?.latitude ?? 0.0, lon1: locationManager.location?.longitude ?? 0.0, lat2: destinationsLat, lon2: destinationsLon)
            
            print("The distance is: \(distanceResult)")
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchPlaceID(for location: String, apiKey: String) async {
        
        /* Gets the place ID that will be used for getting the attractions
         that are within the city
         */
        
        let encodedLocation = location.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://api.geoapify.com/v1/geocode/search?text=\(encodedLocation)&apiKey=\(apiKey)"
        guard let url = URL(string: urlString) else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let response = try JSONDecoder().decode(GeocodingResponse.self, from: data)
            
            placeID = response.features.first?.properties.place_id ?? ""
            
            print("Place ID is: \(placeID)")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getPlaces(apiKey: String) async {
        
        // Limit query to 20 attractions
        
        // Uses the place ID and gets the attractions in the given city
        
        let placesString = "https://api.geoapify.com/v2/places?categories=tourism.attraction&filter=place:\(placeID)&limit=20&apiKey=\(apiKey)"
        
        guard let placesURL = URL(string: placesString) else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: placesURL)
            
            print(data)
            
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Raw JSON data: \(jsonString)")
            }
            
            let decoder = JSONDecoder()
            
            if let response = try? decoder.decode(FeatureCollection.self, from: data) {
                featureCollection = response.features
                print("Successfully decoded the data: \(response)")
                resultsAreAvaliable = true
                print(featureCollection)
                
                if response.features == [] {
                    noResultsFound = true
                }
                
                
            } else {
                print("Failed to get the results.")
                noResultsFound = true
            }
        } catch {
            print("Error getting the places: \(error.localizedDescription)")
        }
    }
    
    func setInitialUserRegion() {
        
        /* When the user first opens the app, if they have location services allowed,
         set the position to where they are currently at, else set in US Region.
         */
        
        
        if CLLocationManager.locationServicesEnabled() {
            mapCameraPosition = .userLocation(fallback: .region(unitedStatesRegion))
        }
    }
    
    func resetSearchText() {
        
        // Resets all variables that are involved in the search process
        
        searchText = ""
        autocompletionSearchText = ""
        featureCollection = [Feature]()
        autocompletionResults = [CityAutocomplete]()
        resultsAreAvaliable = false
        searchWasSubmitted = false
        resultsAreLoaded = false
        runQueryTask = false
        autoCompletionTouched = false
        placeID = ""
        distanceResult = 0.0
        readyToCalculateDistance = false
    }
    
    func removeNoResultsFoundView() {
        
        // Remove the No Results Found view after 2 seconds
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.noResultsFound = false
        }
    }
    
    func searchAutocompletion(acAPIKEY: String) async {
        
        // Uses the query to find cities similar what the query contains. Consists of 5 options to select from.
        
        let query = searchText
        
        guard let url = URL(string: "https://api.geoapify.com/v1/geocode/autocomplete?text=\(query)&limit=5&format=json&apiKey=\(acAPIKEY)") else {
            return
        }
        
        do {
            
            let (data, _) = try await URLSession.shared.data(from: url)
            
            print(data)
            
            let decorder = JSONDecoder()
            
            if let response = try? decorder.decode(Results.self, from: data) {
                autocompletionResults = response.results
                print(response)
                
                if autocompletionResults == [] {
                    resultsAreLoaded = false
                    noResultsFound = true
                } else {
                    resultsAreLoaded = true
                }
                
            } else {
                print("Failure decoding the response")
            }
            
        } catch {
            print("Error getting data: \(error.localizedDescription)")
        }
    }
    
    func setAutocompletionText(item: CityAutocomplete) {
        
        /* When the user selects the autocompletion city, replace the search text with it
         and call the other async methods
         */
        
        
        self.autocompletionSearchText = "\(item.city ?? "N/A"), \(item.state), \(item.country)"
        searchText = autocompletionSearchText
        autoCompletionTouched = true
        print(autocompletionSearchText)
        
        print("The value of autocompletiontouched is: \(autoCompletionTouched)")
        
        if autoCompletionTouched {
            print("Running tasks!")
            Task {
                
                if searchText == "" {
                    mapCameraPosition = .userLocation(fallback: .region(unitedStatesRegion))
                } else {
                    await returnSearchResults()
                    readyToCalculateDistance = true
                    await fetchPlaceID(for: autocompletionSearchText, apiKey: "e24cb77dcb4f49c9abb36ab68d52661c")
                    await getPlaces(apiKey: "e24cb77dcb4f49c9abb36ab68d52661c")
                }
            }
        }
    }
    
    func haversineDistance(lat1: Double, lon1: Double, lat2: Double, lon2: Double) -> Double {
        
        print(lat1, lon1, lat2, lon2)
        // Convert degrees to radians
        let dLat = (lat2 - lat1).degreesToRadians
        let dLon = (lon2 - lon1).degreesToRadians
        let originLat = lat1.degreesToRadians
        let destinationLat = lat2.degreesToRadians
        
        print(dLat, dLon, originLat, destinationLat)
        
        // Haversine formula
        let a = sin(dLat / 2) * sin(dLat / 2) +
        sin(dLon / 2) * sin(dLon / 2) * cos(originLat) * cos(destinationLat)
        let c = 2 * atan2(sqrt(a), sqrt(1 - a))
        
        // Earth radius in miles
        return 3958.8 * c
    }
}
