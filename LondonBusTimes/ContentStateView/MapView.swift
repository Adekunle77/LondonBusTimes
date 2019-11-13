//
//  ViewController.swift
//  LondonBusTimes
//
//  Created by Ade Adegoke on 19/09/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import UIKit
import MapKit
import Combine

fileprivate enum CollectionViewSection: CaseIterable {
    case main
}

fileprivate typealias DataSourese = UICollectionViewDiffableDataSource<CollectionViewSection, BusStop>

class MapView: UIViewController, UICollectionViewDelegate {
    
    weak var coordinator: MainCoordinator?
    private var viewModel: MapViewModel?
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet private weak var collectionView: UICollectionView!
    private var collectionViewTwo: UICollectionView!
    private var dataSource: DataSourese?
    private var busAssignSubscriber: AnyCancellable?
    var busStops = [BusStop]()
    
    private var arrivalTimes: [Stop]? {
        
        didSet {
            guard let arrivalTimes = arrivalTimes else { return }
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MapViewModel()
        viewModel?.delegate = self
        //let layout = UICollectionViewFlowLayout()
        collectionViewTwo = UICollectionView(frame: view.bounds, collectionViewLayout: createCollectionViewlayout())
        collectionViewTwo.autoresizingMask = [.flexibleWidth, .flexibleHeight]
              collectionViewTwo.backgroundColor = .systemBackground
        collectionViewTwo.register(BusStopCell.self, forCellWithReuseIdentifier: BusStopCell.reuseIdentifier)
        view.addSubview(collectionViewTwo)
        self.collectionViewTwo.dataSource = dataSource
         collectionViewTwo.delegate = self
        

        
        
        
        self.collectionView.dataSource = dataSource
        collectionView.delegate = self
        collectionView.register(UINib.init(nibName: "StopCell", bundle: nil),
                                 forCellWithReuseIdentifier: "cell")
        
//                collectionViewTwo.layer.shadowColor = UIColor.lightGray.cgColor
//                collectionViewTwo.layer.shadowOffset = CGSize(width: 0, height: 2.0)
//                collectionViewTwo.layer.shadowRadius = 5.0
//                collectionViewTwo.layer.shadowOpacity = 1.0
//                collectionViewTwo.layer.masksToBounds = false
//        let screenSize: CGRect = UIScreen.main.bounds
//
//        collectionView.frame = CGRect(x: 0, y: 0, width: screenSize.width - 20, height: screenSize.height / 2)
        
      //  collectionViewTwo.layer.shadowPath = UIBezierPath(roundedRect: self.view.bounds, cornerRadius: self.view.cor).cgPath
                collectionViewTwo.layer.backgroundColor = UIColor.clear.cgColor
        //
        //        collectionViewTwo.contentView.layer.masksToBounds = true
        //        layer.cornerRadius = 7.5
                
        
        self.setSourceSetUp()
        var snapShop = NSDiffableDataSourceSnapshot<CollectionViewSection, BusStop>()
        snapShop.appendSections([.main])
        snapShop.appendItems(busStops, toSection: .main)
        self.dataSource?.apply(snapShop, animatingDifferences: true)
   
        
        
       // viewModel?.getAllStopsData(with: busStops ?? [])
      //  print(busStops, "ggggggggg")
        
//        busAssignSubscriber = self.viewModel?.$arrivalTimes.sink { (data) in
//            //self.viewModel?.kjrnfskv(jhwfbcj: data ?? [], jwhefbskcd: self.busStops ?? [])
//            guard let times = data else {return }
//            
//            self.arrivalTimes = self.viewModel?.sortAllEarliestBuses(with: times, busStops: self.busStops ?? [])
//           // print(self.viewModel?.sortAllEarliestBuses(with: times, busStops: self.busStops ?? []), "fdffff")
//        }
     //   print("self.arrivalTimes")
     //   print(self.arrivalTimes)
        
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.coordinator?.childDidFinish(self)
    }

    // collectionView setUp
    
    
    
    
    private func setSourceSetUp() {
            self.dataSource = DataSourese(collectionView: self.collectionViewTwo) { (collectionView: UICollectionView, indexPath: IndexPath,
                               bus: BusStop)  -> UICollectionViewCell? in
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: "cell",
                    for: indexPath) as? BusStopCell else { fatalError("Cannot create new cell") }
//
//                cell.layer.cornerRadius = 10
//                cell.layer.masksToBounds = false
//            cell
                
                cell.backgroundColor = .white
                
                self.viewModel?.getAllStopsData(with: bus.naptanId)
                self.busAssignSubscriber = self.viewModel?.$arrivalTimes.sink { (data) in

//                    cell.arrivalTime.text = data?.first?.stationName
//                    cell.busNumber.text = data?.first?.lineName
//                    cell.destination.text =  data?.first?.destinationName
                   // cell.arrivalTime.text = "String(bus.timeToStation)"
                }
              //  print(bus.commonName, "hhhhhhhhhhh")
//
             
                return cell
        }
    }
    
    private func createCollectionViewlayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 12.5, leading: 25, bottom: 12.5, trailing: 25)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(550))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let layouut = UICollectionViewCompositionalLayout(section: section)

        return layouut
    }
}

extension MapView: Storyboarded {}
extension MapView: MKMapViewDelegate {}

extension MapView: UICollectionViewDelegateFlowLayout {
//    func collectionView(_: UICollectionView,
//                        layout _: UICollectionViewLayout,
//                        sizeForItemAt _: IndexPath) -> CGSize {
//        let width = view.bounds.size.width
//        let height = view.bounds.size.height
//        return CGSize(width: width - 180, height: height - 330)
//    }
}

extension MapView: MapViewModelDelegate {
    func didUpdateWithData(with stops: [ArrivalTime]) {


    }
}
