//
//  CapsuleForDetailView.swift
//  ExploreIt
//
//  Created by Elyan Gutierrez on 8/22/24.
//

import SwiftUI

struct CapsuleForDetailView: View {
    
    let customPurple = Color(red: 0.2, green: 0.30, blue: 0.9)
    
    var categories: [String]
    
    var getMainCategories: [String] {
        var mainArray = [String]()
        
        for category in categories {
            if !category.contains(".") && !category.contains("man_made") {
                mainArray.append(category)
            }
        }
        
        return mainArray
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(getMainCategories, id: \.self) { category in
                    Text(category.capitalized)
                        .foregroundStyle(customPurple)
                        .font(.subheadline)
                        .frame(height: 30)
                        .fontWeight(.bold)
                        .background(
                            RoundedRectangle(cornerRadius: 15.0)
                                .fill(.cyan.opacity(0.15))
                                .padding(.horizontal, -10)
                        )
                    
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
