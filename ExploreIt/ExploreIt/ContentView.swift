//
//  ContentView.swift
//  ExploreIt
//
//  Created by Elyan Gutierrez on 8/16/24.
//

import MapKit
import SwiftUI


struct ContentView: View {
    @Namespace var scopeForMap
    @FocusState var isFocused: Bool
    
    @State private var mapCameraPosition: MapCameraPosition = .automatic
    @State private var searchText = ""
    @State private var landmarks = [Landmark]()
    @State private var featureCollection = [Feature]()
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 50, longitude: 50), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    @State private var toggle3DMode = false
    @State private var placeID = ""
    
    let unitedStatesRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 105.7129, longitude: -95), // Example: San Francisco
        span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
    )
    
    var body: some View {
        Map(position: $mapCameraPosition, scope: scopeForMap) {
//            ForEach(landmarks, id: \.id) { landmark in
//                Marker(landmark.name, coordinate: landmark.coordinate)
//            }
            ForEach(featureCollection, id: \.self) { feature in
                Marker(feature.properties.name, coordinate: feature.geometry.getCoordinates)
            }
        }
        .mapControls {
            MapPitchToggle()
        }
        .mapStyle(.standard(elevation: .realistic))
        .overlay {
            VStack {
                Spacer()
                    .frame(height: 45)
                
                TextField("", text: $searchText, prompt: Text("Enter City, State/Country"))
                    .frame(width: 200, alignment: .center)
                    .tint(.black)
                    .background (
                        RoundedRectangle(cornerRadius: 15.0)
                            .fill(.white)
                            .frame(width: 285, height: 40)
                    )
                    .onSubmit {
                        Task {
                            await returnSearchResults()
                            await fetchPlaceID(for: searchText, apiKey: "e24cb77dcb4f49c9abb36ab68d52661c")
                            await getPlaces(apiKey: "e24cb77dcb4f49c9abb36ab68d52661c")
                        }
                    }
                    .overlay {
                        RoundedRectangle(cornerRadius: 35.0)
                            .fill(.clear)
                            .stroke(.black, lineWidth: 2)
                            .frame(width: 285, height: 40, alignment: .center)
                        
                        Image(systemName: "magnifyingglass")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(.black)
                            .padding(.horizontal, 13)
                        
                        if !searchText.isEmpty {
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 8, height: 8)
                                .foregroundStyle(.black)
                                .fontWeight(.bold)
                                .background(
                                    Circle()
                                        .fill(.gray.opacity(0.30))
                                        .frame(width: 20, height: 20)
                                    
                                )
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.horizontal, 15)
                                .onTapGesture {
                                    resetSearchText()
                                }
                        }
                    }
                    .focused($isFocused)
                
                Spacer()
            }
        }
        .preferredColorScheme(.light)
        .onAppear {
            CLLocationManager().requestWhenInUseAuthorization()
            
            DispatchQueue.global().async { // sets the inital user region off of the main thread
                setInitialUserRegion()
            }
        }
        .onChange(of: searchText) {
            
            if searchText == "" {
                mapCameraPosition = .userLocation(fallback: .region(unitedStatesRegion))
                landmarks = [Landmark]()
                
            } else {
                mapCameraPosition = .automatic
            }
        }
        .onTapGesture {
            isFocused = false
        }
        
    }
    
    func setInitialUserRegion() {
        if CLLocationManager.locationServicesEnabled() {
            mapCameraPosition = .userLocation(fallback: .region(unitedStatesRegion))
        }
    }
    
    func returnSearchResults() async {
        /* Whenever the user searches up a location,
           call the function and return any results if avaliable.
        */
        
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchText
        searchRequest.resultTypes = .pointOfInterest
        
        let search = MKLocalSearch(request: searchRequest)
        
        do {
            let response = try await search.start()
            landmarks = response.mapItems.map { mapItem in
                Landmark(placement: mapItem.placemark)
            }
            
            if let updatedRegion = response.mapItems.first {
                region = MKCoordinateRegion(
                    center: updatedRegion.placemark.coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
                )
            }
            
            if !landmarks.isEmpty {
                for landmark in landmarks {
                    print(landmark.name)
                }
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
            
//            if let jsonString = String(data: data, encoding: .utf8) {
//                print("Raw JSON data: \(jsonString)")
//            }
//            
//            print(data)
            
            let response = try JSONDecoder().decode(GeocodingResponse.self, from: data)
            
            placeID = response.features.first?.properties.place_id ?? ""
            
            print("Place ID is: \(placeID)")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getPlaces(apiKey: String) async {
        
        // Limit query to 10 searchs
        
        let placesString = "https://api.geoapify.com/v2/places?categories=tourism.attraction,tourism.information&filter=place:\(placeID)&limit=10&apiKey=\(apiKey)"
        
        guard let placesURL = URL(string: placesString) else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: placesURL)
            
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Raw JSON data: \(jsonString)")
            }
            
            let decoder = JSONDecoder()
            
            let response = try decoder.decode(FeatureCollection.self, from: data)
            
            featureCollection = response.features
        } catch {
            print("Error getting the places: \(error.localizedDescription)")
        }
        
        print("The Feature Details are: \(featureCollection)")
    }
    
    func resetSearchText() {
        searchText = ""
        featureCollection = [Feature]()
    }
}

#Preview {
    ContentView()
}
