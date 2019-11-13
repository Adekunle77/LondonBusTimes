//
//  ErrorView.swift
//  LondonBusTimes
//
//  Created by Ade Adegoke on 16/09/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import UIKit

class ErrorView: UIViewController {
    weak var coordinator: MainCoordinator?
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.coordinator?.childDidFinish(self)
    }
}

extension ErrorView: Storyboarded {}
