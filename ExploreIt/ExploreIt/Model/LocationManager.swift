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
    var locationServicesInUse = false
    
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
        
        // fix the warning later...
        
        if CLLocationManager.locationServicesEnabled() {
            switch manager.authorizationStatus {
            case .notDetermined, .restricted, .denied:
                locationServicesInUse = false // set to false if location services are not being used
                print("Location Services are not being used.")
            case .authorizedAlways, .authorizedWhenInUse:
                locationServicesInUse = true // set to true if location services are being used
                print("Location Services are being used.")
                location = manager.location?.coordinate
            @unknown default:
                fatalError() // call when a error or unknown situation occurs
            }
        }
    }
}
