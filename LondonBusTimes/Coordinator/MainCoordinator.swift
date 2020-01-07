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
            let contentStateVC = ContentStateView.instantiate()
            contentStateVC.coordinator = self
            self.childCoordinator.append(contentStateVC)
            self.navigationController.pushViewController(contentStateVC, animated: false)
        }
    }
    
    func pushErrorView(error: DataSourceError?) {
        DispatchQueue.main.async {
            let errorVC = ErrorView.instantiate()
            errorVC.errors = error
            errorVC.coordinator = self
            self.childCoordinator.append(errorVC)
            self.navigationController.pushViewController(errorVC, animated: true)
        }
    }
    
    func pushLoadingView() {
        DispatchQueue.main.async {
            let loadingView = LoadingView.instantiate()
            loadingView.coordinator = self
            self.childCoordinator.append(loadingView)
            self.navigationController.pushViewController(loadingView, animated: true)
        }
    }
    
    func pushMapView() {
        DispatchQueue.main.async {
            let mapView = MapView.instantiate()
          //  mapView.coordinator = self
//            mapView.arrivalTimes = arrivalTimes
//            mapView.busStops = busStop
//            mapView.userCurrentCoordinatess = coordinates
           
            self.childCoordinator.append(mapView)
            self.navigationController.pushViewController(mapView, animated: true)
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
