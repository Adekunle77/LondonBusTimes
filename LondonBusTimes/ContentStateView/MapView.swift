//
//  ViewController.swift
//  LondonBusTimes
//
//  Created by Ade Adegoke on 19/09/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import UIKit
import Combine

fileprivate enum CollectionViewSection: CaseIterable {
    case main
}

fileprivate typealias CollectionViewDataSource = UICollectionViewDiffableDataSource<CollectionViewSection, Stop>

class MapView: UIViewController, UICollectionViewDelegate {
    weak var coordinator: MainCoordinator?
    private var viewModel: MapViewModel?
    
    private var subscriptions = Set<AnyCancellable>()
    private var dataSource = DataSource()
    private var collectionViewTwo: UICollectionView!
    private var collectionViewDataSource: CollectionViewDataSource?
    
    var busStops = [BusStop]()
    var sortBusStopTimes = [Stop]()
    var userCurrentCoordinatess: Coordinate?
 
    var arrivalTimes = [ArrivalTime]() {
        didSet {
            print(arrivalTimes)
            sortBusStopTimes = self.viewModel?.sortAllEarliestBuses(with: arrivalTimes, busStops: busStops) ?? []
            var snapShop = NSDiffableDataSourceSnapshot<CollectionViewSection, Stop>()
            snapShop.appendSections([.main])
            snapShop.appendItems(sortBusStopTimes, toSection: .main)
            self.collectionViewDataSource?.apply(snapShop, animatingDifferences: true)
        }
    }
    
    private var dataSourceError: DataSourceError? {
        didSet {
            if dataSourceError != nil {
                var jcgsvcjbs = [Error]()
                
                guard let jhcjhcd = dataSourceError else { return }
                print(jhcjhcd)
                jcgsvcjbs.append(jhcjhcd)
                self.coordinator?.pushErrorView(error: jcgsvcjbs)
            }
        }
    }

    
    
    


    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MapViewModel()
        
        busStops = self.dataSource.busStops ?? []
        self.dataSource.$arrivalTimes.assign(to: \.arrivalTimes, on: self).store(in: &subscriptions)
        self.dataSource.$dataSourceError.assign(to: \.dataSourceError, on: self).store(in: &subscriptions)
        
        
        viewModel?.delegate = self
        
        
        collectionViewTwo = UICollectionView(frame: view.bounds, collectionViewLayout: createCollectionViewlayout())
        collectionViewTwo.autoresizingMask = [.flexibleWidth, .flexibleHeight]
              collectionViewTwo.backgroundColor = .systemBackground
        collectionViewTwo.register(BusStopCell.self, forCellWithReuseIdentifier: BusStopCell.reuseIdentifier)
        view.addSubview(collectionViewTwo)
        self.collectionViewTwo.dataSource = collectionViewDataSource
        collectionViewTwo.delegate = self
        collectionViewTwo.layer.backgroundColor = UIColor.clear.cgColor
        
        
        self.setSourceSetUp()
        
        

    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.coordinator?.childDidFinish(self)
    }

    private func setSourceSetUp() {
            self.collectionViewDataSource = CollectionViewDataSource(collectionView: self.collectionViewTwo) { (collectionView: UICollectionView, indexPath: IndexPath,
                               stop: Stop)  -> UICollectionViewCell? in
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: "cell",
                    for: indexPath) as? BusStopCell else { fatalError("Cannot create new cell") }
                cell.backgroundColor = .white
                cell.updateCell(with: stop, coordinates: self.userCurrentCoordinatess ?? (0.0, 0.0))
                
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
extension MapView: UICollectionViewDelegateFlowLayout {}

extension MapView: MapViewModelDelegate {
    func didUpdateWithData(with stops: [ArrivalTime]) {
   
    }
}
