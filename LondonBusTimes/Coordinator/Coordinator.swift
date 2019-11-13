//
//  Coordinator.swift
//  LondonBusTimes
//
//  Created by Ade Adegoke on 14/09/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    func start()
}
