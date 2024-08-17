//
//  ContentView.swift
//  ExploreIt
//
//  Created by Elyan Gutierrez on 8/16/24.
//

import MapKit
import SwiftUI


struct ContentView: View {
    
    @State private var searchText = ""
    @State private var landmarks = [Landmark]()
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 50, longitude: 50), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    @FocusState var isFocused: Bool
    
    var body: some View {
        Map {
            ForEach(landmarks, id: \.id) { landmark in
                Marker(landmark.name, coordinate: landmark.coordinate)
            }
        }
        .overlay {
            VStack {
                
                Spacer()
                    .frame(height: 40)
                
                TextField("", text: $searchText, prompt: Text("Enter Location"))
                    .frame(width: 230, alignment: .center)
                    .tint(.black)
                    .background (
                        RoundedRectangle(cornerRadius: 15.0)
                            .fill(.regularMaterial)
                            .frame(width: 320, height: 40)
                    )
                    .onSubmit {
                        Task {
                            await returnSearchResults()
                        }
                    }
                    .overlay {
                        RoundedRectangle(cornerRadius: 15.0)
                            .fill(.clear)
                            .stroke(.gray.opacity(0.80), lineWidth: 2)
                            .frame(width: 315, height: 40, alignment: .center)
                        
                        Image(systemName: "magnifyingglass")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 8)
                        
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 7, height: 7)
                            .fontWeight(.bold)
                            .background(
                                Circle()
                                    .fill(.gray.opacity(0.60))
                                    .frame(width: 20, height: 20)
                                
                            )
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.horizontal, 15)
                    }
                    .focused($isFocused)
                
                Spacer()
            }
        }
        .onTapGesture {
            isFocused = false
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
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    ContentView()
}
