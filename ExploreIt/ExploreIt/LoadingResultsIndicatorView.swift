//
//  LoadingResultsIndicatorView.swift
//  ExploreIt
//
//  Created by Elyan Gutierrez on 8/18/24.
//

import SwiftUI

struct LoadingResultsIndicatorView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 15.0)
            .fill(.regularMaterial)
            .frame(width: 150, height: 80)
            .overlay {
                VStack {
                    ProgressView() {
                        Text("Loading Sites...")
                    }
                }
            }
    }
}

#Preview {
    LoadingResultsIndicatorView()
}
