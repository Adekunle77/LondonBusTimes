//
//  ContentStateViewModel.swift
//  LondonBusTimes
//
//  Created by Ade Adegoke on 12/09/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation
import Combine

class ContentStateViewModel {

    var subscriptions = Set<AnyCancellable>()
    let dataSource: DataSource?
    var arrivalTimes = [ArrivalTime]()
    
    init() {
        self.dataSource = DataSource()
        self.dataSource?.$arrivalTimes.assign(to: \.arrivalTimes, on: self).store(in: &subscriptions)
    }
}
