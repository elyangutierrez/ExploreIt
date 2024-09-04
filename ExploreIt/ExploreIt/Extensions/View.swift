//
//  View.swift
//  ExploreIt
//
//  Created by Elyan Gutierrez on 9/2/24.
//

import Foundation
import SwiftUI

extension View {
    func glow(isDarkModeOn: ColorScheme, radius: CGFloat) -> some View {
        self
            .shadow(color: isDarkModeOn == .dark ? .white : .gray, radius: 15)
    }
    
    func iconShapeGlow(color: Color, radius: CGFloat) -> some View {
        self
            .shadow(color: color.opacity(0.60), radius: radius)
            .shadow(color: color, radius: radius / 2)
            .shadow(color: color, radius: radius / 3)
    }
    
    func searchbarGlow(color: Color, radius: CGFloat) -> some View {
        self
            .shadow(color: color, radius: radius / 2)
            .shadow(color: color, radius: radius / 2)
    }
    
    func capsuleGlow(color: Color, radius: CGFloat) -> some View {
        self
            .shadow(color: color, radius: radius)
    }
}
