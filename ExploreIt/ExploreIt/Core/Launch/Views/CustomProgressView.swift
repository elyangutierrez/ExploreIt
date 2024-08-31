//
//  CustomProgressView.swift
//  ExploreIt
//
//  Created by Elyan Gutierrez on 8/30/24.
//

import SwiftUI

struct CustomProgressView: View {
    let progress: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width, height: 10)
                    .opacity(0.3)
                    .foregroundStyle(.gray)
                
                Rectangle()
                    .frame(
                        width: min(progress * geometry.size.width, geometry.size.width), height: 10)
                    .foregroundStyle(.white)
            }
        }
    }
}

//#Preview {
//    CustomProgressView(progress: 10)
//}
