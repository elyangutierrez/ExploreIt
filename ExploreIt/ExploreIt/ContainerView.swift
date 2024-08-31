//
//  ContainerView.swift
//  ExploreIt
//
//  Created by Elyan Gutierrez on 8/30/24.
//

import SwiftUI

struct ContainerView: View {
    
    @State private var isSplashScreenViewPresented = true
    
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
