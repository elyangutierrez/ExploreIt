//
//  LocationManager.swift
//  ExploreIt
//
//  Created by Elyan Gutierrez on 8/25/24.
//

import CoreLocation
import Foundation

@Observable
class LocationManager: NSObject, CLLocationManagerDelegate {
    let manager = CLLocationManager() // manager that manages location services
    
    var location: CLLocationCoordinate2D? // the current user's location
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func requestPermissionToGetUserLocation() {
        manager.requestWhenInUseAuthorization() // requests permission based on what we have defined in the plist
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate // sets the location to the first one out of the array
    }
    
    func checkIfLocationServicesAreInUse() {
        
        // Move operations off of the main queue
        
        let locationServicesSwitch = DispatchQueue(label: "locationServicesSwitch")
        
        locationServicesSwitch.async { [self] in
            if CLLocationManager.locationServicesEnabled() {
                switch manager.authorizationStatus {
                case .notDetermined:
                    manager.requestWhenInUseAuthorization()
                case .restricted:
                    print("Location restricted")
                case .denied:
                    print("Location denied")
                case .authorizedAlways:
                    print("Location authorizedAlways")
                    location = manager.location?.coordinate
                case .authorizedWhenInUse:
                    print("Location authorized when in use.")
                    location = manager.location?.coordinate
                @unknown default:
                    print("Location service disabled.")
                }
            }
        }
    }
}
