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
    private var collectionView: UICollectionView!
    private var collectionViewDataSource: CollectionViewDataSource?
    private var headView = UIView()
    let refreshButton = UIButton(type: .custom)
    
    var busStops = [BusStop]() {
        didSet {
          
        }
    }
    var sortBusStopTimes = [Stop]()
    var userCurrentCoordinatess: Coordinate?
 
    var arrivalTimes = [ArrivalTime]() {
        didSet {
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
                
                jcgsvcjbs.append(jhcjhcd)
               // self.coordinator?.pushErrorView(error: jcgsvcjbs)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MapViewModel()
        busStops = self.dataSource.busStops
        self.dataSource.$arrivalTimes.assign(to: \.arrivalTimes, on: self).store(in: &subscriptions)
        self.dataSource.$busStops.assign(to: \.busStops, on: self).store(in: &subscriptions)
        self.dataSource.$dataSourceError.assign(to: \.dataSourceError, on: self).store(in: &subscriptions)
        viewModel?.delegate = self
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCollectionViewlayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.register(BusStopCell.self, forCellWithReuseIdentifier: BusStopCell.reuseIdentifier)
        self.collectionView.dataSource = collectionViewDataSource
        collectionView.delegate = self
        collectionView.layer.backgroundColor = UIColor.clear.cgColor
        collectionView.frame = CGRect(x: 0, y: 100, width: self.view.frame.width, height: self.view.frame.height - 90)
        view.addSubview(collectionView)

        refreshButton.backgroundColor = .clear
        refreshButton.setTitle("Press here to update the times", for: .normal)
        refreshButton.layer.borderWidth = 1
        refreshButton.layer.borderColor = UIColor.white.cgColor
        refreshButton.frame = CGRect(x: 20, y: 50, width: self.view.frame.width - 50, height: 30)
        refreshButton.addTarget(self, action: #selector(MapView.pushContentStateView), for: .touchUpInside)
        refreshButton.center.x = self.view.center.x
        self.view.addSubview(refreshButton)
        self.setSourceSetUp()
 
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.coordinator?.childDidFinish(self)
    }

    @objc func pushContentStateView() {
      print("Button Clicked")
    }

    private func setSourceSetUp() {
            self.collectionViewDataSource = CollectionViewDataSource(collectionView: self.collectionView) { (collectionView: UICollectionView, indexPath: IndexPath,
                               stop: Stop)  -> UICollectionViewCell? in
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: "cell",
                    for: indexPath) as? BusStopCell else { fatalError("Cannot create new cell") }
                cell.backgroundColor = .white
                guard let coordinates = self.dataSource.coordinates else { return cell }
          
                cell.updateCell(with: stop, coordinates: coordinates)
        
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
    
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .fractionalHeight(3.5))
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return layoutSectionHeader
    }
}

extension MapView: Storyboarded {}
extension MapView: UICollectionViewDelegateFlowLayout {}

extension MapView: MapViewModelDelegate {
    func didUpdateWithData(with stops: [ArrivalTime]) {
    }
}
