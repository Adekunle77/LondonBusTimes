//
//  BusStopCellModel.swift
//  LondonBusTimes
//
//  Created by Ade Adegoke on 30/10/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

class BusStopCellModel {
    private var locationService: LocationService?
    var usersCurrentCoordinates: Coordinate?
    
    init() {
        locationService = LocationService(coordinates: { result in
            self.usersCurrentCoordinates = result
        })
    }
    
    
    func setMapView(mapView: MKMapView) {
        guard let coordinates = usersCurrentCoordinates else { return }
        let locatoion = CLLocation(latitude: coordinates.latitude,
                                   longitude: coordinates.longitude)
        let viewRegion = MKCoordinateRegion(center: locatoion.coordinate,
                                            latitudinalMeters: 250,
                                            longitudinalMeters: 250)
        mapView.setRegion(viewRegion, animated: true)
    }
    
}

