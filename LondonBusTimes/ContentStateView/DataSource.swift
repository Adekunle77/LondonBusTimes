//
//  DataSource.swift
//  LondonBusTimes
//
//  Created by Ade Adegoke on 11/12/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Combine
import Foundation

class DataSource: ObservableObject {
    
    private let dispatchGroup = DispatchGroup()
    private var busStopSubcriber = BusStopsSubscriber()
    private var apiRequest: APIRequest?
    private var locationService: LocationService?
    private var disposables = Set<AnyCancellable>()
    private var coordinates: Coordinate?
    @Published var allArrivalTimes = [ArrivalTime]()
    @Published var arrivalTimes = [ArrivalTime]()
    @Published var busStops: [BusStop]?
    @Published var dataSourceError: DataSourceError?

    init() {
        busStopSubcriber = BusStopsSubscriber()
        locationService = LocationService(coordinates: { result in
            self.apiRequest = APIRequest(endPoints: .findLocalStops(using: result))
            self.findLocalBusStops(with: result)
        })
        
    }
    
    private func findLocalBusStops(with coordinates: Coordinate) {
        apiRequest?.fetchBusStopData(with: .findLocalStops(using: coordinates))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.dataSourceError = error
                }
            }, receiveValue: { busStops in
                self.dispatchGroup.enter()
                self.busStops = busStops
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
                        }).store(in: &self.disposables)
                    }
                    self.dispatchGroup.leave()
                    self.dispatchGroup.notify(queue: .main) {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                            self.arrivalTimes = self.allArrivalTimes
                        }
                    }
                }).store(in: &disposables)
    }
}
