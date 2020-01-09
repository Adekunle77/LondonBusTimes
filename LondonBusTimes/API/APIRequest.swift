//
//  APIRequest.swift
//  LondonBusTimes
//
//  Created by Ade Adegoke on 09/09/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation
import Combine

final class APIRequest: API {
    private let session: URLSession
    private let decoder: JSONDecoder
    let endPoints: Endpoints
    
    init(session: URLSession = .shared, decoder: JSONDecoder = .init(), endPoints: Endpoints) {
        self.session = session
        self.decoder = decoder
        self.endPoints = endPoints
    }
}

extension APIRequest {
    
    func fetchBusStopData(with endPoints: Endpoints) -> AnyPublisher<[BusStop], DataSourceError> {
        guard let url = endPoints.url else { preconditionFailure("Can't create url for query: \(endPoints)") }
        return session.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .mapError { DataSourceError.network($0) }
            .map { $0.data }
            .decode(type: TravelInformation.self, decoder: decoder)
            .mapError { _ in DataSourceError.noData }
            .map { $0.stopPoints}
            .eraseToAnyPublisher()
    }

    func fetchBusesData(with busID: String) -> AnyPublisher<[ArrivalTime], DataSourceError> {
        let url = "https://api.tfl.gov.uk/StopPoint/\(busID)//arrivals"
        guard let busIdURL = URL(string: url) else { preconditionFailure("Can't create url for query: \(busID)") }
        return session.dataTaskPublisher(for: busIdURL)
            .receive(on: DispatchQueue.main)
            .mapError { DataSourceError.network($0) }
            .map { $0.data }
            .decode(type: [ArrivalTime].self, decoder: decoder)
            .mapError { _ in DataSourceError.noData }
            .map { $0 }
            .eraseToAnyPublisher()
        }
}
