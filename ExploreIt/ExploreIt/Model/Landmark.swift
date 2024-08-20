//
//  Landmark.swift
//  ExploreIt
//
//  Created by Elyan Gutierrez on 8/16/24.
//

import CoreLocation
import Foundation
import MapKit

struct Landmark: Identifiable {
    var id = UUID()
    var name: String
    let coordinate: CLLocationCoordinate2D
    
    init(placement: MKPlacemark) {
        self.name = placement.name ?? "Unknown"
        self.coordinate = placement.coordinate
    }
}
