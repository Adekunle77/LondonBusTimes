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
    func didUpdateWithData(arrivalTime: [ArrivalTime], busStop: [BusStop], coordinates: Coordinate)
    func didUpdateWithError(error: Error)
    func dataIsLoading()
}

class ContentStateViewModel {
    let dispatchGroup = DispatchGroup()
    let queue = DispatchQueue.global(qos: .userInitiated)
    private var busStopSubcriber = BusStopsSubscriber()
    private var apiRequest: APIRequest?
    private var locationService: LocationService?
    weak var delegate: LoadingManagerDelegate?
    private var coordinates: Coordinate?
    private var busStopAssignSubscriber: AnyCancellable?
    private var busStopFailureSubscriber: AnyCancellable?
    @Published var allArrivalTimes = [ArrivalTime]()
    @Published var arrivalTimes: [ArrivalTime]? {
        didSet {
            guard let arrivalTimes = arrivalTimes else { return }
            guard let busStops = self.busStops else { return }
            guard coordinates != nil else { return }
            self.delegate?.didUpdateWithData(
                arrivalTime: arrivalTimes,
                busStop: busStops,
                coordinates: coordinates ?? (0.0, 0.0))
        }
    }

    @Published var busStops: [BusStop]? {
        didSet {
            guard busStops != nil else { return }
        }
    }

    @Published var dataSourceError: DataSourceError? {
        didSet {
            guard let error = dataSourceError else { return }
            self.delegate?.didUpdateWithError(error: error)
        }
    }

    init() {
        self.busStopSubcriber = BusStopsSubscriber()
        locationService = LocationService(coordinates: { (result) in
            self.coordinates = result
            self.apiRequest = APIRequest(endPoints: .findLocalStops(using: result))
            self.findLocalBusStops(with: result)
        })
    }
    
    
    private func findLocalBusStops(with coordinates: Coordinate) {
       _ = self.apiRequest?.fetchBusStopData(with: .findLocalStops(using: coordinates))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.dataSourceError = error
                }
            }, receiveValue: { busStops in
                self.busStops = busStops
                self.dispatchGroup.enter()
                for busStop in busStops {
                    _ = self.apiRequest?.fetchBusesData(with: busStop.naptanId)
                        .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            break
                        case .failure(let error):
                            self.dataSourceError = error
                    }
                        
                    }, receiveValue: { stops in
                        for y in stops {
                            self.allArrivalTimes.append(y)
                        }
                    })
                }
                self.dispatchGroup.leave()
                self.dispatchGroup.notify(queue: .main) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        self.arrivalTimes = self.allArrivalTimes
                    }
                }
            })

        self.busStopFailureSubscriber = busStopSubcriber.$error.assign(to: \.dataSourceError, on: self)
    }

    func isDataAvailble() {
        if arrivalTimes?.count == 00 && dataSourceError == nil {
            self.delegate?.dataIsLoading()
        }
    }
}
