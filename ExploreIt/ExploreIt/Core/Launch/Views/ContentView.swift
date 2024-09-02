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
        ".purple": .purple,
        ".neonRed": .neonRed,
        ".neonOrange": .neonOrange,
        ".neonYellow": .neonYellow,
        ".neonGreen": .neonGreen,
        ".neonTeal": .neonTeal,
        ".neonCyan": .neonCyan,
        ".neonBlue": .neonBlue,
        ".neonIndigo": .neonIndigo,
        ".neonPurple": .neonPurple,
        ".neonBrown": .neonBrown
    ]
    
    var getFallbackRegion: MKCoordinateRegion {
        let fallbackRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: viewModel.locationManager.location?.latitude ?? 0.0, longitude: viewModel.locationManager.location?.longitude ?? 0.0), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        
        return fallbackRegion
    }
    
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
                }
            }
        }
        
        // Moved sheet outside of loop to prevent automatic sheet closure
        .sheet(item: $viewModel.currentAttraction) { attraction in
            ShowAttractionDetailsView(attraction: attraction)
                .presentationBackground(.regularMaterial)
                .presentationDetents([.height(450)])
                .presentationCornerRadius(25.0)
                .presentationDragIndicator(.visible)
        }
        .mapControls {
            MapPitchToggle()
        }
        .mapStyle(.standard(elevation: .realistic))
        .overlay {
            VStack {
                Spacer()
                    .frame(height: 45)
                
                TextField("", text: $viewModel.searchText, prompt: Text("Enter Destination"))
                    .frame(width: 200, alignment: .center)
                    .tint(.black)
                    .background (
                        RoundedRectangle(cornerRadius: 15.0)
                            .foregroundStyle(.regularMaterial)
                            .frame(width: 282.5, height: 40)
                    )
                    .onSubmit {
                        
                        print("Search text: \(viewModel.searchText)")
                        
                        viewModel.checkSearchText(searchText: viewModel.searchText)
                        
                        Task {
                            
                            /* API key is for owners use only. Plesae create your own
                             if you want to expand further using geoapify.com */
                            
                            /* When the user hits enter, call the autocompletion func, display results,
                             and when they select the correct city, perform regulars operations.
                             */
                            
                            await viewModel.searchAutocompletion(acAPIKEY: "363a1e1be51546fea723fe6ec44ae341")
                            
                            // moved other async calls to the searchAutocompletion method
                            
                        }
                        
                        viewModel.searchWasSubmitted = true
                    }
                    .overlay {
                        RoundedRectangle(cornerRadius: 35.0)
                            .fill(.clear)
                            .stroke(isFocused ? .blue : .black, lineWidth: 2)
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
                
                if viewModel.autoCompletionTouched && !viewModel.resultsAreAvaliable {
                    LoadingResultsIndicatorView()
                        .frame(maxHeight: .infinity, alignment: .center)
                    
                    // Display auto completion results here.
                    
                    Spacer()
                        .frame(height: 30)
                } else if viewModel.noResultsFound {
                    NoResultsFoundView()
                        .frame(maxHeight: .infinity, alignment: .center)
                        .onAppear {
                            viewModel.removeNoResultsFoundView()
                        }
                    
                    Spacer()
                        .frame(height: 60)
                }
                
                if viewModel.searchWasSubmitted {
                    
                    Spacer()
                        .frame(height: 5)
                    
                    ZStack {
                        if viewModel.resultsAreLoaded {
                            VStack(alignment: .leading) {
                                Spacer()
                                    .frame(height: 10)
                                
                                ForEach(viewModel.autocompletionResults, id: \.self) { item in
                                    Text("\(item.city ?? "N/A"), \(item.state), \(item.country)")
                                        .font(.system(size: 14))
                                        .padding(.bottom, 15)
                                        .onTapGesture {
                                            viewModel.setAutocompletionText(item: item)

                                            print("Touched the city item.")
                                            
                                            viewModel.searchWasSubmitted = false
                                        }
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 85)
                            .background(
                                RoundedRectangle(cornerRadius: 10.0)
                                    .fill(.regularMaterial)
                                    .frame(width: 270)
                                    .shadow(radius: 5)
//                                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
                            )
                            .padding(.vertical, -3)
                        }
                    }
                    
                    Spacer()
                        .frame(maxHeight: .infinity, alignment: .top)
                }
                
                if viewModel.resultsAreAvaliable {
                    
                    VStack {
                        Text(viewModel.distanceResult.convertDistanceToString + "mi")
                            .background(
                                RoundedRectangle(cornerRadius: 5.0)
                                    .fill(.regularMaterial)
                                    .stroke(.black.opacity(0.80), lineWidth: 1)
                                    .padding(.horizontal, -5)
                                    .padding(.vertical, -5)
                            )
                    }
                    .frame(maxWidth: .infinity, alignment: .bottomLeading)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 35)
                }
                
            }
        }
        .previewInterfaceOrientation(.portrait)
        .preferredColorScheme(.light)
        .onAppear {
            viewModel.locationManager.checkIfLocationServicesAreInUse()
            
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                if let coordinate = viewModel.locationManager.location {
                    print("Latitude is: \(coordinate.latitude)")
                    print("Longitude is: \(coordinate.longitude)")
                } else {
                    print("No location.")
                }
            }
            
            DispatchQueue.global().async { // sets the inital user region off of the main thread
                viewModel.setInitialUserRegion()
            }
        }
        .onChange(of: viewModel.searchText) {
            if viewModel.searchText == "" {
                viewModel.mapCameraPosition = .userLocation(fallback: .region(getFallbackRegion))
                viewModel.landmarks = [Landmark]()
                print("Clearing search")
            }
        }
        .onTapGesture {
            isFocused = false
        }
        .alert(viewModel.alertTitle, isPresented: $viewModel.showInvalidInputAlert) {
            Button("Ok", role: .cancel) { }
        } message: {
            Text(viewModel.alertMessage)
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
