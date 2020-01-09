//
//  MainCoordinator.swift
//  LondonBusTimes
//
//  Created by Ade Adegoke on 14/09/2019.
//  Copyright © 2019 AKA. All rights reserved.
//
import Foundation
import UIKit

final class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {

    private var childCoordinator = [UIViewController]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        DispatchQueue.main.async {
            self.navigationController.delegate = self
            let contentStateVC = ContentStateViewController.instantiate()
            contentStateVC.coordinator = self
            self.childCoordinator.append(contentStateVC)
            self.navigationController.pushViewController(contentStateVC, animated: false)
        }
    }
    
    func pushErrorViewController(error: DataSourceError?) {
        DispatchQueue.main.async {
            let errorVC = ErrorViewController.instantiate()
            errorVC.errors = error
            errorVC.coordinator = self
            self.childCoordinator.append(errorVC)
            self.navigationController.pushViewController(errorVC, animated: true)
        }
    }
    
    func pushContentStateView() {
        DispatchQueue.main.async {
            let contentStateView = ContentStateViewController.instantiate()
            contentStateView.coordinator = self
            self.childCoordinator.append(contentStateView)
            self.navigationController.pushViewController(contentStateView, animated: true)
        }
    }
        
    func pushBusStopsViewController() {
        DispatchQueue.main.async {
            let busStopsViewController = BusStopsViewController.instantiate()
            busStopsViewController.coordinator = self
            self.childCoordinator.append(busStopsViewController)
            self.navigationController.pushViewController(busStopsViewController, animated: true)
        }
    }

    func childDidFinish(_ child: UIViewController) {
        if let index = childCoordinator.firstIndex(where: { (coordinator) -> Bool in coordinator == child }) {
            DispatchQueue.main.async {
                self.childCoordinator.remove(at: index)
            }
        }
    }
}
