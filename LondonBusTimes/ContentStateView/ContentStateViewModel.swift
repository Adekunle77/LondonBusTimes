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
    func didUpdateWithData()
    func didUpdateWithError(error: Error)
    func dataIsLoading()
}

class ContentStateViewModel {
    weak var delegate: LoadingManagerDelegate?
    
    
   
}
