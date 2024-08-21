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
            
            Spacer()
                .frame(height: 15)
            
            HStack {
                Text("Area:")
                    .font(.title3)
                    .fontWeight(.medium)
            }
            
            Text("City: \(attraction.properties.city ?? "N/A")")
            Text("County: \(attraction.properties.county ?? "N/A")")
            Text("State: \(attraction.properties.state ?? "N/A")")
            Text("Country: \(attraction.properties.country ?? "N/A")")
            Text("Postal Code: \(attraction.properties.postcode ?? "N/A")")
            
            Spacer()
                .frame(height: 15)
            
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 2, alignment: .center)
                .foregroundStyle(.gray)
            
            Spacer()
                .frame(height: 15)
            
            HStack {
                Text("Address:")
                    .font(.title3)
                    .fontWeight(.medium)
            }
            
            Text("Address 1: \(attraction.properties.addressLine1 ?? "N/A")")
            Text("Address 2: \(attraction.properties.addressLine2 ?? "N/A")")
            
            Spacer()
                .frame(height: 15)
            
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 2, alignment: .center)
                .foregroundStyle(.gray)
            
            Spacer()
                .frame(height: 55)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 10)
    }
}

//#Preview {
//    ShowAttractionDetailsView()
//}
