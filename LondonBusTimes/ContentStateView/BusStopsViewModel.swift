//
//  mapViewModel.swift
//  LondonBusTimes
//
//  Created by Ade Adegoke on 24/09/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Combine
import Foundation
import MapKit

protocol MapViewModelDelegate: class {
    func didUpdateWithData(with stops: [ArrivalTime])
}

final class BusStopsViewModel {
    private var locationService: LocationService?
    weak var delegate: MapViewModelDelegate?

    private func sortFirstBusToStop(with busTimes: [ArrivalTime], using coordinates: BusStop) -> [Bus] {
        var times = [Bus]()
        for bus in busTimes {
            times.append(Bus(
                busNumber: bus.lineName,
                arrivalTime: bus.timeToStation,
                destination: bus.destinationName))
        }
        return times.sorted { $0.arrivalTime < $1.arrivalTime }
    }

    private func sortBuses(busTimes: [ArrivalTime]) -> [Bus] {
        var buses = [Bus]()
        for bus in busTimes {
            buses.append(Bus(
                busNumber: bus.lineName,
                arrivalTime: bus.timeToStation,
                destination: bus.destinationName))
        }
        return buses.sorted { $0.arrivalTime < $1.arrivalTime }
    }

    func sortAllEarliestBuses(with arrivalTime: [ArrivalTime], busStops: [BusStop]) -> [Stop] {
        var earliestBuses = [Stop]()
        var busSet = Set<String>()
        for stop in arrivalTime {
            busSet.insert(stop.naptanId)
        }

        for item in busSet {
            let buses = arrivalTime.filter { $0.naptanId == item }
            let stops = busStops.filter { $0.naptanId == item }
            let sortBuses = self.sortBuses(busTimes: buses)
            let stop = Stop(
                stopName: buses.first?.stationName ?? "",
                stopID: buses.first?.naptanId ?? "",
                lat: stops.first?.lat ?? 0.0,
                long: stops.first?.lon ?? 0.0,
                distance: stops.first?.distance ?? 0.0,
                buses: sortBuses)
            earliestBuses.append(stop)
        }
        return earliestBuses
    }
}

struct Bus: Hashable {
    var busNumber: String
    var arrivalTime: Int
    var destination: String

    init(busNumber: String,
         arrivalTime: Int,
         destination: String) {
        self.busNumber = busNumber
        self.arrivalTime = arrivalTime
        self.destination = destination
    }
}

struct Stop: Hashable, Equatable {
    var stopName: String
    var stopID: String
    var lat: Double
    var long: Double
    var distance: Double
    var buses: [Bus]

    init(stopName: String,
         stopID: String,
         lat: Double,
         long: Double,
         distance: Double,
         buses: [Bus]) {
        self.stopName = stopName
        self.stopID = stopID
        self.lat = lat
        self.long = long
        self.distance = distance
        self.buses = buses
    }
}
