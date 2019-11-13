////
////  MapsViewController.swift
////  LondonBusTimes
////
////  Created by Ade Adegoke on 18/10/2019.
////  Copyright © 2019 AKA. All rights reserved.
////
//
//import UIKit
//import Combine
//
//fileprivate enum CollectionViewSection: CaseIterable {
//    case main
//}
//
//fileprivate typealias DataSourese = UICollectionViewDiffableDataSource<CollectionViewSection, ArrivalTime>
//
//class MapsViewController: UIViewController {
//
//    weak var coordinator: MainCoordinator?
//    //private var viewModel: MapViewModel?
//    private let viewModel = MapViewModel()
//    private var dataSource: DataSourese?
//    var busStops: [BusStop]?
//    @IBOutlet private weak var collectionView: UICollectionView!
//    private let arrivalTimesTwo = [Stop]()
//    private var busAssignSubscriber: AnyCancellable?
//    
//    private var busStopAssignSubscriber: AnyCancellable?
//    private var busStopFailureSubscriber: AnyCancellable?
//    private var stopAssignSubscriber: AnyCancellable?
//    private var stopFailureSubcriber: AnyCancellable?
//
//    //var collectionView: UICollectionView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        viewModel.delegate = self
////            collectionView = UICollectionView(
////                frame: view.bounds,
////                collectionViewLayout: UICollectionViewFlowLayout())
////           // collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
////            collectionView.backgroundColor = .systemBackground
////            view.addSubview(collectionView)
////        collectionView.translatesAutoresizingMaskIntoConstraints = false
////        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
////        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
////        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
////        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        
//        
//        collectionView.register(StopCell.self, forCellWithReuseIdentifier: StopCell.reuseIdentifier)
//        
//        setSourceSetUp()
//        self.viewModel.getAllStopsData(with: self.busStops ?? [])
//        busAssignSubscriber = self.viewModel.$arrivalTimes.sink { (data) in
//            guard let arrivalTimes = data else { return }
//            let stops = self.viewModel.sortAllEarliestBuses(with: arrivalTimes, busStops: self.busStops ?? [])
//          
//            var snapShop = NSDiffableDataSourceSnapshot<CollectionViewSection, ArrivalTime>()
//            snapShop.appendSections([.main])
//            snapShop.appendItems(arrivalTimes, toSection: .main)
//            self.dataSource?.apply(snapShop)
// 
//        }
//        
//        collectionView.dataSource = dataSource
//    }
//    
////    override func viewDidLayoutSubviews() {
////          super.viewDidLayoutSubviews()
////          collectionView.frame = view.bounds
////      }
//    
//    private func setSourceSetUp() {
//        self.dataSource = DataSourese(collectionView: self.collectionView) { (collectionView: UICollectionView, indexPath: IndexPath,
//            bus: ArrivalTime)  -> UICollectionViewCell? in
//            guard let cell = collectionView.dequeueReusableCell(
//                withReuseIdentifier: StopCell.reuseIdentifier,
//                for: indexPath) as? StopCell else { fatalError("Cannot create new cell") }
//            
//            cell.busNumber?.text = bus.destinationName
//                    
////                cell.busNumber.text = bus.buses.first?.busNumber
////                cell.destinations.text = bus.buses.first?.destination
////                cell.arrivesIn.text = "bus.buses.first.arrivalTime"
//                return cell
//        }
//    }
//}
//
//extension MapsViewController: Storyboarded {}
//
//extension MapsViewController: MapViewModelDelegate {
//    func didUpdateWithData(with stops: [ArrivalTime]) {
//    //   print(stops, "=======================")
//       // print(stops, "hhhhhhhhhhhh")
//     let timess = self.viewModel.sortAllEarliestBuses(with: stops, busStops: busStops ?? [])
//       // print(timess)
//       //print(timess.count, "cdkbcdjhbcdjbhcdjhbcdhjbc")
//    }
//    
//    
//}
