//
//  SplashScreenView.swift
//  ExploreIt
//
//  Created by Elyan Gutierrez on 8/30/24.
//

import SwiftUI

struct SplashScreenView: View {
    
    @State private var scale = CGSize(width: 0.8, height: 0.8)
    @State private var barProgress = 0.0
    @State private var isVisible = true
    @State private var progressWait = true
    @Binding var isPresented: Bool
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.gradiantTestTwo, .gradiantTest], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            ZStack {
                Image(.appLogo)
                    .resizable()
                    .frame(width: 120, height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 15.0))
            }
            .scaleEffect(scale)
            
            VStack {
                Spacer()
                    .frame(height: 290)
                
                if isVisible {
                    CustomProgressView(progress: barProgress)
                        .padding(.horizontal, 50)
                        .frame(height: 10)
                }
            }
        }
        .onAppear {
            
            withAnimation(.easeInOut(duration: 1.5)) {
                scale = CGSize(width: 1.2, height: 1.2)
                barProgress = 1
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.2, execute: {
                isVisible.toggle()
            })
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
                withAnimation(.easeIn(duration: 0.35)) {
                    scale = CGSize(width: 50, height: 50)
                }
            })
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.9, execute: {
                withAnimation(.easeIn(duration: 0.2)) {
                    isPresented.toggle()
                }
            })
            
        }
    }
}

#Preview {
    SplashScreenView(isPresented: .constant(true))
}
