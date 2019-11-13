//
//  Model.swift
//  LondonBusTimes
//
//  Created by Ade Adegoke on 09/09/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation

struct TravellInfomation: Codable {
    var stopPoints: [BusStop]
}

struct BusStop: Codable, Hashable {
    var naptanId: String
    var commonName: String
    var distance: Double
    var additionalProperties: [AdditionalProperties]
    var lat: Double
    var lon: Double
    var lines: [Lines]
}

struct AdditionalProperties: Codable, Hashable {
    var value: String
    var key: String
}

struct Lines: Codable, Hashable {
    var name: String
}

struct BusArrivalData: Codable {
    var stopPoints: [ArrivalTime]
}

struct ArrivalTime: Codable, Hashable {
    var naptanId: String
    var timeToStation: Int
    var stationName: String
    var lineName: String
    var destinationName: String
}

