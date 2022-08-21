//
//  LocationManager.swift
//  ParkFinder
//
//  Created by Noah Glaser on 8/21/22.
//

import UIKit
import MapKit
import CoreLocation
//https://www.hackingwithswift.com/quick-start/swiftui/how-to-show-annotations-in-a-map-view

struct LocationSaved: Identifiable, Codable {
    var id = UUID()
    let createdAt: Date
    let latitude: Double
    let longitude: Double
    
    
    var cooridinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
}

// https://codewithchris.com/swiftui/swiftui-corelocation/
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {

    @Published var region = MKCoordinateRegion()
    
    @Published var annonations: [LocationSaved] = []
    
    // Always stores the current location
    @Published var userLocation = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    // When this is set to true it will recenter the map based on the user's location
    @Published var recenter = true
    
    private let manager = CLLocationManager()

    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        if let jsonString = UserDefaults.standard.string(forKey: "parked") {
            if let data = jsonString.data(using: .utf8) {
                if let location = try? JSONDecoder().decode(LocationSaved.self, from: data) {
                    annonations = [location]
                }
            }
        }
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }

        // If the center is at 0,0 or we need recenter the app
        // run through this.  We don't want to do this and follow the user because
        // it removes the user's ability to control the map
        if Int(region.center.longitude) == 0 || recenter {
            let mapCenter = CLLocationCoordinate2D(
                latitude: location.coordinate.latitude,
                longitude: location.coordinate.longitude
            )
            
            // span is the zoom level
            let zoomLevel = MKCoordinateSpan(
                latitudeDelta:  0.007,
                longitudeDelta: 0.007)
            region = MKCoordinateRegion(center: mapCenter, span: zoomLevel)
            recenter = false
        }
        userLocation = location.coordinate
    }
    
    
    func save() {
        let location = LocationSaved(
            createdAt: Date(),
            latitude: userLocation.latitude,
            longitude: userLocation.longitude
        )
        annonations = [location]
        save(location: location)
    }
    
    func save(location: LocationSaved) {
        do {
            let data = try JSONEncoder().encode(location.self)
            let jsonString = String(data: data, encoding: .utf8)
            UserDefaults.standard.set(jsonString, forKey: "parked")
        } catch {
            print("Error Saving Location")
        }
    }
}

