//
//  ViewController.swift
//  LondonBusTimes
//
//  Created by Ade Adegoke on 11/09/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import UIKit
import Combine
import Lottie

class ContentStateView: UIViewController {
    weak var coordinator: MainCoordinator?
    private var subscriptions = Set<AnyCancellable>()
    private var dataSource = DataSource()
    private var animationView = AnimationView()
    private var arrivalTimes = [ArrivalTime]() {
        didSet {
            if arrivalTimes.count > 0 {
                self.coordinator?.pushMapView()
            }
        }
    }
    /*
     
     CONNECTION ERROR!
     
     No connection error
     
     
     */
    private var dataSourceError: DataSourceError? {
        didSet {
            if dataSourceError != nil {
                self.coordinator?.pushErrorView(error: dataSourceError)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadAnimation()

        self.dataSource.$arrivalTimes.assign(to: \.arrivalTimes, on: self).store(in: &subscriptions)
        self.dataSource.$dataSourceError.assign(to: \.dataSourceError, on: self).store(in: &subscriptions)
        let animation = Animation.named("27-loading")
        self.animationView.animation = animation
        view.addSubview(animationView)
        animationView.contentMode = .scaleAspectFit
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        animationView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        animationView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        self.lottieViewSetup()
       
    }

    private func loadAnimation() {
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.coordinator?.childDidFinish(self)
    }

    private func lottieViewSetup() {
        self.animationView.loopMode = .loop
        self.animationView.play()
     }
}

extension ContentStateView: Storyboarded {}
