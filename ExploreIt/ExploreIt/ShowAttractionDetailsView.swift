//
//  ShowAttractionDetailsView.swift
//  ExploreIt
//
//  Created by Elyan Gutierrez on 8/19/24.
//

import SwiftUI

struct ShowAttractionDetailsView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var attraction: Feature
    
    var body: some View {
        
        
        VStack(alignment: .leading) {
            
            Text("Attraction Info")
                .font(.title.bold())
            
            HStack {
                Text("Area:")
                Rectangle()
                    .frame(width: 360, height: 2)
            }
            
            Text("City: \(attraction.properties.city ?? "N/A")")
            Text("County: \(attraction.properties.county ?? "N/A")")
            Text("State: \(attraction.properties.state ?? "N/A")")
            Text("Country: \(attraction.properties.country ?? "N/A")")
            Text("Postal Code: \(attraction.properties.postcode ?? "N/A")")
            
            HStack {
                Text("Address")
                Rectangle()
                    .frame(width: 335, height: 2)
            }
            
            Text("Address 1: \(attraction.properties.addressLine1 ?? "N/A")")
            Text("Address 2: \(attraction.properties.addressLine2 ?? "N/A")")
            
            
            
            
            
            Text(attraction.properties.name ?? "")
            
            Spacer()
                .frame(height: 250)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 10)
    }
}

//#Preview {
//    ShowAttractionDetailsView()
//}
