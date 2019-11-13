//
//  DataSourceError.swift
//  LondonBusTimes
//
//  Created by Ade Adegoke on 09/09/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation

enum DataSourceError: Error {
    case fatel(String)
    case network(Error)
    case noData
    case dataError(Error)
    case jsonParseError(Error)
}
