//
//  SplashScreenView.swift
//  ExploreIt
//
//  Created by Elyan Gutierrez on 8/30/24.
//

import SwiftUI

struct SplashScreenView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var scale = CGSize(width: 0.8, height: 0.8)
    @State private var barProgress = 0.0
    @State private var isVisible = false
    @State private var progressWait = true
    @State private var textOpacity = 1.0
    @Binding var isPresented: Bool
    var viewModel = ViewModel()
    
    var currentMode: Color {
        if colorScheme == .dark {
            return .black
        } else {
            return .white
        }
    }
    
    var body: some View {
        ZStack {
            currentMode
                .ignoresSafeArea()
            
            ZStack {
                Image(.appLogo)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 15.0))
                    .glow(isDarkModeOn: colorScheme, radius: 15)
                    .overlay {
                        RoundedRectangle(cornerRadius: 15.0)
                            .fill(.clear)
                            .stroke(.black.opacity(0.05), lineWidth: 1)
                            .frame(width: 100, height: 100)
                    }
            }
            .scaleEffect(scale)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1.5)) {
                scale = CGSize(width: 1.1, height: 1.1)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.2, execute: {
                withAnimation(.smooth(duration: 0.7)) {
                    isPresented.toggle()
                }
            })
            
        }
    }
}

#Preview {
    SplashScreenView(isPresented: .constant(true))
}
