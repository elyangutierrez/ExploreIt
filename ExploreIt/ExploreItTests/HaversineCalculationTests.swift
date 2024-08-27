//
//  HaversineCalculationTests.swift
//  ExploreItTests
//
//  Created by Elyan Gutierrez on 8/27/24.
//

import XCTest
@testable import ExploreIt

final class HaversineCalculationTests: XCTestCase {

    func testSuccessfulHaversineDistance() {
        // Arrange
        let lat1 = 40.7128
        let lon1 = -74.0060
        let lat2 = 34.0522
        let lon2 = -118.2437
        let model = ViewModel()
        
        // Act
        var distance: Double {
            return model.haversineDistance(lat1: lat1, lon1: lon1, lat2: lat2, lon2: lon2)
        }
        
        // Assert
        XCTAssertEqual(distance, 2445.586606929677)
    }
    
    func testOverrangeHaversineDistance() {
        // Arrange
        let lat1 = 40.7128
        let lon1 = -74.0060
        let lat2 = 34.0522
        let lon2 = -200.0
        let model = ViewModel()
        
        // Act
        var distance: Double {
            return model.haversineDistance(lat1: lat1, lon1: lon1, lat2: lat2, lon2: lon2)
        }
        
        // Assert
        XCTAssertLessThan(lon2, -180.0)
    }
}
