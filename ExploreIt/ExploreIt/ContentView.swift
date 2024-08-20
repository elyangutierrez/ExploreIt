//
//  ContentView.swift
//  ExploreIt
//
//  Created by Elyan Gutierrez on 8/16/24.
//

import MapKit
import SwiftUI


struct ContentView: View {
    @FocusState var isFocused: Bool
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 50, longitude: 50), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    @State private var toggle3DMode = false
    @State private var showAttactionSheet = false
    @State private var viewModel = ViewModel()
    
    let colorMap: [String: Color] = [
        ".red": .red,
        ".orange": .orange,
        ".yellow": .yellow,
        ".green" : .green,
        ".teal": .teal,
        ".cyan": .cyan,
        ".blue": .blue,
        ".indigo": .indigo,
        ".brown": .brown,
        ".purple": .purple
    ]
    
    var body: some View {
        Map(position: $viewModel.mapCameraPosition) {
            ForEach(viewModel.featureCollection, id: \.self) { feature in
                Annotation(feature.properties.name ?? "N/A", coordinate: feature.geometry.getCoordinates, anchor: .top) {
                    Circle()
                        .fill(convertStringToColor(feature: feature))
                        .frame(width: 30, height: 30)
                        .overlay {
                            ShowMapIconView(catagory: feature.properties.getCatagory)
                                .font(.system(size: 16))
                        }
                        .background(
                            Circle()
                                .fill(convertStringToColor(feature: feature).opacity(0.60))
                                .frame(width: 35, height: 35)
                                .background(
                                    Circle()
                                        .fill(convertStringToColor(feature: feature).opacity(0.40))
                                        .frame(width: 40, height: 40)
                                        .background(
                                            Circle()
                                                .fill(convertStringToColor(feature: feature).opacity(0.20))
                                                .frame(width: 45, height: 45)
                                        )
                                )
                        )
                        .onTapGesture {
                            print("Touched Annotation!")
                            viewModel.currentAttraction = feature
                            showAttactionSheet.toggle()
                        }
                        .sheet(item: $viewModel.currentAttraction) { attraction in
                            ShowAttractionDetailsView(attraction: attraction)
                                .presentationDetents([.height(600)])
                                .presentationCornerRadius(25.0)
                        }
                        // This sheet method is causing my app to not build.
                }
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
                
                TextField("", text: $viewModel.searchText, prompt: Text("Enter City, State/Country"))
                    .frame(width: 200, alignment: .center)
                    .tint(.black)
                    .background (
                        RoundedRectangle(cornerRadius: 15.0)
                            .fill(.white)
                            .frame(width: 285, height: 40)
                    )
                    .onSubmit {
                        Task {
                            
                            // API key is for owners use only.
                            
                            await viewModel.returnSearchResults()
                            await viewModel.fetchPlaceID(for: viewModel.searchText, apiKey: "e24cb77dcb4f49c9abb36ab68d52661c")
                            await viewModel.getPlaces(apiKey: "e24cb77dcb4f49c9abb36ab68d52661c")
                        }
                        
                        viewModel.searchWasSubmitted = true
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
                        
                        if !viewModel.searchText.isEmpty {
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
                                    viewModel.resetSearchText()
                                }
                        }
                    }
                    .focused($isFocused)
                
                Spacer()
                
                /* After the user submits their search, show a loading view until the results data is decoded and ready to go.
                   If the data does not exist, show another view and then after a period of time remove the view.
                 */
                
                if viewModel.searchWasSubmitted && !viewModel.resultsAreAvaliable {
                    LoadingResultsIndicatorView()
                        .frame(maxHeight: .infinity, alignment: .center)
                    
                    Spacer()
                        .frame(height: 60)
                } else if viewModel.noResultsFound {
                    NoResultsFoundView()
                        .frame(maxHeight: .infinity, alignment: .center)
                        .onAppear {
                            viewModel.removeNoResultsFoundView()
                        }
                    
                    Spacer()
                        .frame(height: 60)
                }
                
            }
        }
        .previewInterfaceOrientation(.portrait)
        .preferredColorScheme(.light)
        .onAppear {
            CLLocationManager().requestWhenInUseAuthorization()
            
            DispatchQueue.global().async { // sets the inital user region off of the main thread
                viewModel.setInitialUserRegion()
            }
        }
        .onChange(of: viewModel.searchText) {
            
            if viewModel.searchText == "" {
                viewModel.mapCameraPosition = .userLocation(fallback: .region(viewModel.unitedStatesRegion))
                viewModel.landmarks = [Landmark]()
                
            } else {
                viewModel.mapCameraPosition = .automatic
            }
        }
        .onTapGesture {
            isFocused = false
        }
        
    }
    
    func convertStringToColor(feature: Feature) -> Color {
        let colorString = feature.properties.getCategoryColor
        
        print("Color is: \(colorString)")
        
        if let color = colorMap[colorString] {
            return color
        }
        return Color.white
        
    }
}

#Preview {
    ContentView()
}
