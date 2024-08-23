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
        ScrollView(.vertical, showsIndicators: false) {
            
            Spacer()
                .frame(height: 10)
            
            VStack {
                CapsuleForDetailView(categories: attraction.properties.categories)
            }
            
            VStack(alignment: .leading) {
                // Content details and attraction info here
                
                Text(attraction.properties.name ?? "N/A")
                    .font(.title2.bold())
                    .lineLimit(2)
                
                //            Rectangle()
                //                .fill(.gray.opacity(0.20))
                //                .frame(maxWidth: .infinity, maxHeight: 2, alignment: .center)
                
                Divider()
                
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
                
                //            Spacer()
                //                .frame(height: 10)
                
                Divider()
                
                Text("Address")
                    .font(.title3)
                    .fontWeight(.medium)
                
                Spacer()
                    .frame(height: 10)
                
                Text("Main Address: \(attraction.properties.addressLine1 ?? "N/A")")
                Text("Secondary Address: \(attraction.properties.addressLine2 ?? "N/A")")
                
                Spacer()
                    .frame(height: 20)
                
                //            Rectangle()
                //                .fill(.gray.opacity(0.20))
                //                .frame(maxWidth: .infinity, maxHeight: 2, alignment: .center)
                
                Divider()
                
                Text("Contact Info")
                    .font(.title3)
                    .fontWeight(.medium)
                
                Spacer()
                    .frame(height: 10)
                
//                Text("Phone Number: \(attraction.properties.contact?.phone ?? "N/A")")
                if let phoneNumber = attraction.properties.contact?.phone {
                    let numberWithDashes = phoneNumber.replacingOccurrences(of: "-", with: "")
                    HStack {
                        Text("Phone Number:")
                        
                        VStack {
                            Link(destination: URL(string: "tel:\(numberWithDashes)")!) {
                                Text(phoneNumber)
                            }
                        }
                    }
                } else {
                    Text("Phone Number: N/A")
                }
                
                if let email = attraction.properties.contact?.email {
                    HStack {
                        Text("Email:")
                        
                        VStack {
                            Link(destination: URL(string: "mailto:\(email)")!) {
                                Text(email)
                            }
                        }
                    }
                } else {
                    Text("Email: N/A")
                }
                
                
                if let website = attraction.properties.website {
                    
                    Text("Website:")
                    
                    VStack(alignment: .leading) {
                        Link(destination: URL(string: website)!) {
                            Text(website)
                                .multilineTextAlignment(.leading)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                } else {
                    Text("Website: N/A")
                }
                
                Divider()
                
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 15)
        }
    }
}

//#Preview {
//    ShowAttractionDetailsView()
//}
