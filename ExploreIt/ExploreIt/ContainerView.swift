//
//  ContainerView.swift
//  ExploreIt
//
//  Created by Elyan Gutierrez on 8/30/24.
//

import SwiftUI

struct ContainerView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State private var isSplashScreenViewPresented = true
    
    var currentMode: Color {
        if colorScheme == .dark {
            return .black
        } else {
            return .white
        }
    }
    
    var body: some View {
        if !isSplashScreenViewPresented {
            ContentView()
        } else {
            SplashScreenView(isPresented: $isSplashScreenViewPresented)
        }
    }
}

#Preview {
    ContainerView()
}
