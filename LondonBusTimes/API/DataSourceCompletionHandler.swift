//
//  DataSourceCompletionHandler.swift
//  LondonBusTimes
//
//  Created by Ade Adegoke on 09/09/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ results: Result<[BusStop], DataSourceError>) -> Void
