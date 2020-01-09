//
//  ViewController.swift
//  LondonBusTimes
//
//  Created by Ade Adegoke on 11/09/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Combine
import Lottie
import UIKit

class ContentStateViewController: UIViewController {
    weak var coordinator: MainCoordinator?
    private var subscriptions = Set<AnyCancellable>()
    private var dataSource = DataSource()
    private var animationView = AnimationView()
    let imageView = UIImageView()
    let appName = UILabel()

    private var arrivalTimes = [ArrivalTime]() {
        didSet {
            if arrivalTimes.count > 0 {
                coordinator?.pushBusStopsViewController()
            }
        }
    }

    private var dataSourceError: DataSourceError? {
        didSet {
            if dataSourceError != nil {
                self.coordinator?.pushErrorViewController(error: dataSourceError)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        appName.font = UIFont.preferredFont(forTextStyle: .subheadline)
        appName.textColor = .label
        appName.textAlignment = .right
        appName.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(appName)

        dataSource.$arrivalTimes.assign(to: \.arrivalTimes, on: self).store(in: &subscriptions)
        dataSource.$dataSourceError.assign(to: \.dataSourceError, on: self).store(in: &subscriptions)
        let animation = Animation.named("27-loading")
        animationView.animation = animation
        view.addSubview(animationView)
        animationView.contentMode = .scaleAspectFit
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        animationView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        animationView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        lottieViewSetup()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        coordinator?.childDidFinish(self)
    }

    private func lottieViewSetup() {
        animationView.loopMode = .loop
        animationView.play()
    }
}

extension ContentStateViewController: Storyboarded {}
