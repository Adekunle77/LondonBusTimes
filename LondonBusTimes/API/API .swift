//
//  API .swift
//  LondonBusTimes
//
//  Created by Ade Adegoke on 11/09/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation
import Combine

protocol API {
    func fetchBusStopData(with endPoints: Endpoints) -> AnyPublisher<[BusStop], DataSourceError>
    func fetchBusesData(with busID: String) -> AnyPublisher<[ArrivalTime], DataSourceError> 
}
