//
//  LocationService.swift
//  LondonBusTimes
//
//  Created by Ade Adegoke on 09/09/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation
import CoreLocation

class LocationService: NSObject, CLLocationManagerDelegate {

    private var didReceiveLocation = false
    private let locationManager = CLLocationManager()
    private var status: Status?
    var currentCoordinate: Coordinate?
    let coordinates: (Coordinate) -> ()

    private enum Status {
        case notDetermined, disabled, denied, authorised
    }

    init(coordinates: @escaping(Coordinate) -> ()) {
        self.coordinates = coordinates
        status = .notDetermined
        super.init()
        self.locationManagerSetup()
    }

    private func locationManagerSetup() {
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                status = .notDetermined
                self.locationManager.requestWhenInUseAuthorization()
            case .restricted, .denied:
                status = .denied
            case .authorizedAlways, .authorizedWhenInUse:
                status = .authorised
            @unknown default:
                status = .denied
            }
        } else {
            status = .authorised
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined, .restricted, .denied:
            self.status = .notDetermined
        case .authorizedAlways, .authorizedWhenInUse:
            self.status = .authorised
            self.locationManager.startUpdatingLocation()
        @unknown default:
            self.status = .authorised
        }
    }

    func locationManager(_ coreLocationManager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if didReceiveLocation { return }
        guard let location = locations.last else { return }
        didReceiveLocation = true
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        coreLocationManager.stopUpdatingLocation()
        self.currentCoordinate = (latitude, longitude)
        self.coordinates((latitude, longitude))
    }
}

