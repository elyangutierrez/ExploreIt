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

extension ContentView {
    @Observable
    class ViewModel {
        
        var searchText = ""
        var landmarks = [Landmark]()
        var featureCollection = [Feature]()
        var mapCameraPosition: MapCameraPosition = .automatic
        var placeID = ""
        var noResultsFound = false
        var resultsAreAvaliable = false
        var searchWasSubmitted = false
        var currentAttraction: Feature? = nil
        
        let unitedStatesRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 105.7129, longitude: -95), // Example: San Francisco
            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        )
        
        func returnSearchResults() async {
            let searchRequest = MKLocalSearch.Request()
            searchRequest.naturalLanguageQuery = searchText
            
            let search = MKLocalSearch(request: searchRequest)
            
            do {
                let response = try await search.start()
                landmarks = response.mapItems.map { mapItem in
                    Landmark(placement: mapItem.placemark)
                }
                
                if let updatedRegion = response.mapItems.first {
                    mapCameraPosition = .region(MKCoordinateRegion(center: updatedRegion.placemark.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)))
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        
        func fetchPlaceID(for location: String, apiKey: String) async {
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
            
            // Limit query to 20 searchs
            
            // increase the amount of searches later on once model is more secure and failsafe.
            
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
            if CLLocationManager.locationServicesEnabled() {
                mapCameraPosition = .userLocation(fallback: .region(unitedStatesRegion))
            }
        }
        
        func resetSearchText() {
            searchText = ""
            featureCollection = [Feature]()
            resultsAreAvaliable = false
            searchWasSubmitted = false
        }
        
        func removeNoResultsFoundView() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.noResultsFound = false
            }
        }
    }
}
