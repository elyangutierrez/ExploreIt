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
        
        VStack {
            CapsuleForDetailView(categories: attraction.properties.categories)
        }
        
        VStack(alignment: .leading) {
            // Content details and attraction info here
            
            Text(attraction.properties.name ?? "N/A")
                .font(.title2.bold())
                .lineLimit(2)
            
            Rectangle()
                .fill(.gray.opacity(0.20))
                .frame(maxWidth: .infinity, maxHeight: 2, alignment: .center)
            
            Text("Location")
                .font(.title3)
                .fontWeight(.medium)
            
            Spacer()
                .frame(height: 10)
            
            Text("City: \(attraction.properties.city ?? "N/A")")
            Text("County: \(attraction.properties.county ?? "N/A")")
            Text("State: \(attraction.properties.state ?? "N/A")")
            Text("Country: \(attraction.properties.country ?? "N/A")")
            Text("Postal Code: \(attraction.properties.postcode ?? "N/A")")
            Text("State Code: \(attraction.properties.stateCode ?? "N/A")")
            Text("Country Code: \(attraction.properties.countryCode ?? "N/A")")
            
            Spacer()
                .frame(height: 10)
            
            Text("Address")
                .font(.title3)
                .fontWeight(.medium)
            
            Spacer()
                .frame(height: 10)
            
            Text("Main Address: \(attraction.properties.addressLine1 ?? "N/A")")
            Text("Secondary Address: \(attraction.properties.addressLine2 ?? "N/A")")
            
            Spacer()
                .frame(height: 20)
            
            Rectangle()
                .fill(.gray.opacity(0.20))
                .frame(maxWidth: .infinity, maxHeight: 2, alignment: .center)
            
            // main spacer
            
            Spacer()
                .frame(height: 10)
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 15)
    }
}

//#Preview {
//    ShowAttractionDetailsView()
//}
