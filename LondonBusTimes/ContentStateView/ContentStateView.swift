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
    private var viewModel: ContentStateViewModel?
    var animationView = AnimationView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = ContentStateViewModel()
        self.viewModel?.delegate = self
    
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

extension ContentStateView: LoadingManagerDelegate {

    func didUpdateWithData() {
        self.coordinator?.pushMapView() 
    }

    func didUpdateWithError(error: Error) {
        self.coordinator?.pushErrorView()
    }

    func dataIsLoading() {
        self.coordinator?.pushLoadingView()
    }
}
