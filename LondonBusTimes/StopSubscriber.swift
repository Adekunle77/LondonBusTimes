//
//  StopSubscriber.swift
//  LondonBusTimes
//
//  Created by Ade Adegoke on 26/09/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation
import Combine

final class StopSubscriber: Subscriber {
    
    typealias Input = [ArrivalTime]
    typealias Failure = DataSourceError
    
    @Published var busTimes: [ArrivalTime]?
    @Published var error: DataSourceError?
    
    func receive(subscription: Subscription) {
        subscription.request(.max(1))
    }
    
    func receive(_ input: [ArrivalTime]) -> Subscribers.Demand {
        busTimes = input
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

