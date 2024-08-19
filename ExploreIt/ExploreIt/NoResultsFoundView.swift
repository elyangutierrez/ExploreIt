//
//  NoResultsFoundView.swift
//  ExploreIt
//
//  Created by Elyan Gutierrez on 8/18/24.
//

import SwiftUI

struct NoResultsFoundView: View {
    var body: some View {
        Text("No Results Found...")
            .foregroundStyle(.gray)
            .background(
                RoundedRectangle(cornerRadius: 15.0)
                    .fill(.regularMaterial)
                    .frame(width: 180, height: 60)
            )
    }
}

#Preview {
    NoResultsFoundView()
}
