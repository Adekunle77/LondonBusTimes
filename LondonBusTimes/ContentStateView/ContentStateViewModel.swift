//
//  ContentStateViewModel.swift
//  LondonBusTimes
//
//  Created by Ade Adegoke on 12/09/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation
import Combine

protocol LoadingManagerDelegate: class {
    func didUpdateWithData(with busStops: [BusStop])
    func didUpdateWithError(error: Error)
    func updateData(busStop: [BusStop], arrivalTime: [ArrivalTime])
    func dataIsLoading()
}

class ContentStateViewModel {
 
    private let dispatchGroup = DispatchGroup()
    private var stopSubcriber = StopSubscriber()
    private var stopAssignSubscriber: AnyCancellable?
    private var stopFailureSubcriber: AnyCancellable?
    private var busStopSubcriber = BusStopsSubscriber()
    private var apiRequest: APIRequest?
    private var locationService: LocationService?
    weak var delegate: LoadingManagerDelegate?
    var count = 0
    private var busStopAssignSubscriber: AnyCancellable?
    private var busStopFailureSubscriber: AnyCancellable?

    @Published var error: DataSourceError? {
        didSet {
           // print(error?.localizedDescription)
        }
    }
    @Published var dataSourceError: DataSourceError? {
        didSet {
            guard let error = dataSourceError else { return }
            self.delegate?.didUpdateWithError(error: error)
        }
    }

    @Published var busStop: [BusStop]? {
        didSet {
            guard let busStop = busStop else { return }
            
        }
    }
    
    @Published var arrivalTimes: [ArrivalTime]? {
        didSet {
            guard let arrivalTimes = arrivalTimes else { return  }
            guard let busStop = busStop else { return }
            dispatchGroup.notify(queue: .main, execute: {
                self.delegate?.updateData(busStop: busStop, arrivalTime: arrivalTimes)
            })
        }
    }

    init() {
        self.busStopSubcriber = BusStopsSubscriber()
        locationService = LocationService(coordinates: { (result) in
            self.apiRequest = APIRequest(endPoints: .findLocalStops(using: result))
            self.findLocalBusStops(with: result)
        })
        
    }
    
    private func apiRequestStopData(with stopID: [BusStop]) {
        self.dispatchGroup.enter()
        for id in stopID {
            self.apiRequest?.fatchBusesData(with: id.naptanId).receive(subscriber: stopSubcriber)
            self.stopAssignSubscriber = stopSubcriber.$busTimes.assign(to: \.arrivalTimes, on: self)
            self.stopFailureSubcriber = stopSubcriber.$error.assign(to: \.error, on: self)
        }
        self.dispatchGroup.leave()
    }

    
    
    private func findLocalBusStops(with coordinates: Coordinate) {
        self.apiRequest?.fatchBusStopData(with: .findLocalStops(using: coordinates)).receive(subscriber: busStopSubcriber)
        self.busStopAssignSubscriber = busStopSubcriber.$busStops.assign(to: \.busStop, on: self)
        self.busStopFailureSubscriber = busStopSubcriber.$error.assign(to: \.dataSourceError, on: self)
    }
    
    func isDataAvailble() {
        if busStop?.count == 00 && dataSourceError == nil {
            self.delegate?.dataIsLoading()
        }
    }
}
