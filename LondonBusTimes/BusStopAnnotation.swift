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
    var title: String?
    var busDirection: String
    var busNumber: String
    var arrivalTime: String
    var annotationasSubtitle: String
    var image: UIImage?
    
    init(coordinate: CLLocationCoordinate2D,
         title: String, busStopTitle: String,
         busDirection: String,
         arrivalTime: String,
         annotationasSubtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.busDirection = busDirection
        self.busNumber = busStopTitle
        self.arrivalTime = arrivalTime
        self.annotationasSubtitle = annotationasSubtitle
        super.init()
    }
}
