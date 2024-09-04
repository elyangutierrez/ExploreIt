//
//  CapsuleForDetailView.swift
//  ExploreIt
//
//  Created by Elyan Gutierrez on 8/22/24.
//

import SwiftUI

struct CapsuleForDetailView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    let customPurple = Color(red: 0.2, green: 0.30, blue: 0.9)
    
    var categories: [String]
    
    var getMainCategories: [String] {
        
        // Gets categories that are not so specific
        
        var mainArray = [String]()
        var itemToAppend = ""
        
        for category in categories {
            if !category.contains(".") {
                if category.contains("_") {
                    itemToAppend = category.replacingOccurrences(of: "_", with: " ")
                    mainArray.append(itemToAppend)
                } else {
                    mainArray.append(category)
                }
            }
        }
        
        return mainArray
    }
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(getMainCategories, id: \.self) { category in
                    Text(category.capitalized)
                        .foregroundStyle(colorScheme == .dark ? .dark : .light)
                        .font(.subheadline)
                        .frame(height: 30)
                        .fontWeight(.bold)
                        .background(
                            RoundedRectangle(cornerRadius: 15.0)
                                .fill(.cyan.opacity(0.15))
                                .padding(.horizontal, -10)
                        )
                        .shadow(color: colorScheme == .dark ? .dark : .light, radius: colorScheme == .dark ? 3 : 0)
                    
                    Spacer()
                        .frame(width: 30)
                }
            }
            .padding(.horizontal, 25)
        }
        .frame(height: 50)
    }
}

#Preview {
    CapsuleForDetailView(categories: ["Building", "Church", "Tourism", "D.", "E."])
}
