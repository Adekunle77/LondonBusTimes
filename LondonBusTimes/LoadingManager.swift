//
//  LoadingManager.swift
//  LondonBusTimes
//
//  Created by Ade Adegoke on 12/09/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

//import Foundation
//import Combine
//
//final class LoadingManager {
//    private var coordinator: Coordinate?
//    private var busStopSubcriber = BusStopsSubscriber()
//    private var apiRequest: APIRequest?
//    private var locationService: LocationService?
//
//    private var busStopAssignSubscriber: AnyCancellable?
//    private var busStopFailureSubscriber: AnyCancellable?
//
//    @Published var busStop: [BusStop]?
//    @Published var error: DataSourceError?
//    
//    init() {
//        self.busStopSubcriber = BusStopsSubscriber()
//        locationService = LocationService(coordinates: { (result) in
//            self.apiRequest = APIRequest(endPoints: .findLocalStops(using: result))
//            self.findLocalBusStops(with: result)
//        })
//    }
//
//    private func findLocalBusStops(with coordinates: Coordinate) {
//        self.apiRequest?.fetchBusStopData(with: .findLocalStops(using: coordinates)).receive(subscriber: busStopSubcriber)
//        self.busStopAssignSubscriber = busStopSubcriber.$busStops.assign(to: \.busStop, on: self)
//        self.busStopFailureSubscriber = busStopSubcriber.$error.assign(to: \.error, on: self)
//    }
//}
