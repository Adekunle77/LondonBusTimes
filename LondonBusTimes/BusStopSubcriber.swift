//
//  BusStopSubcriber.swift
//  LondonBusTimes
//
//  Created by Ade Adegoke on 12/09/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation
import Combine

//class BusStopSubscriber: Subscriber {
//
//    typealias Input = [BusStop]
//    typealias Failure = Error
//
//    @Published var stops: [BusStop] = []
//    @Published var errors: DataSourceError?
//
//    func receive(subscription: Subscription) {
//        subscription.request(.unlimited)
//    }
//
//    func receive(_ input: [BusStop]) -> Subscribers.Demand {
//        self.stops = input
//        return .unlimited
//    }
//
//    func receive(completion: Subscribers.Completion<Error>) {
//        switch completion {
//        case .failure(let error):
//            self.errors = error as? DataSourceError
//        default:
//            return
//        }
//    }
//}


class BusStopsSubscriber: Subscriber {
    
    typealias Input = [BusStop]
    typealias Failure = DataSourceError
    
    @Published var busStops: [BusStop]?
    @Published var error: DataSourceError?
   // @Published var activity: Bool?

    func receive(subscription: Subscription) {
        subscription.request(.max(1))
    }
    
    func receive(_ input: [BusStop]) -> Subscribers.Demand {
        busStops = input
        return .none
    }
    
    func receive(completion: Subscribers.Completion<DataSourceError>) {
        switch completion {
        case .failure(let error):
            self.error = error 
        default:
            return
        }
    }
}

