//
//  ViewController.swift
//  LondonBusTimes
//
//  Created by Ade Adegoke on 11/09/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import UIKit
import Combine


class ContentStateView: UIViewController {
    weak var coordinator: MainCoordinator?
    private let viewModel = ContentStateViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.delegate = self
        self.viewModel.isDataAvailble()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.coordinator?.childDidFinish(self)
    }
}

extension ContentStateView: Storyboarded {}

extension ContentStateView: LoadingManagerDelegate {
    func didUpdateWithData(with busStops: [BusStop]) {
        self.coordinator?.pushMapView(with: busStops)
    }

    func didUpdateWithError(error: Error) {
        self.coordinator?.pushErrorView()
    }
    
    func dataIsLoading() {
        self.coordinator?.pushLoadingView()
    }
}
