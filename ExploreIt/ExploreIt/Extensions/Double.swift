//
//  Double.swift
//  ExploreIt
//
//  Created by Elyan Gutierrez on 8/25/24.
//

import Foundation

extension Double {
    var degreesToRadians: Double {
        return self * .pi / 180
    }
    
    var convertDistanceToString: String {
        return String(format: "%.2f", self)
    }
}
