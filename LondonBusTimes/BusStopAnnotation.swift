//
//  BusStopAnnotation.swift
//  LondonBusTimes
//
//  Created by Ade Adegoke on 24/09/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation
import MapKit

class BusStopAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var busStopName: String
  //  var             : [/* Array of what each bus  numbers, location(lat long, & bustop name) arrival times */]
    init(coordinate: CLLocationCoordinate2D, busStopName: String) {
        self.coordinate = coordinate
        self.busStopName = busStopName
    }
}
