//
//  ViewController.swift
//  LondonBusTimes
//
//  Created by Ade Adegoke on 19/09/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Combine
import UIKit

fileprivate enum CollectionViewSection: CaseIterable {
    case main
}

fileprivate typealias CollectionViewDataSource = UICollectionViewDiffableDataSource<CollectionViewSection, Stop>

class BusStopsViewController: UIViewController, UICollectionViewDelegate {
    var coordinator: MainCoordinator?
    private var viewModel: BusStopsViewModel?
    private var subscriptions = Set<AnyCancellable>()
    private var dataSource = DataSource()
    private var collectionView: UICollectionView!
    private var collectionViewDataSource: CollectionViewDataSource?
    private var headView = UIView()
    let refreshButton = UIButton(type: .custom)
    
    var busStops = [BusStop]() {
        didSet {}
    }
    
    var sortBusStopTimes = [Stop]()
    var userCurrentCoordinates: Coordinate?
    
    var arrivalTimes = [ArrivalTime]() {
        didSet {
            sortBusStopTimes = viewModel?.sortAllEarliestBuses(with: arrivalTimes, busStops: busStops) ?? []
            var snapShop = NSDiffableDataSourceSnapshot<CollectionViewSection, Stop>()
            snapShop.appendSections([.main])
            snapShop.appendItems(sortBusStopTimes, toSection: .main)
            collectionViewDataSource?.apply(snapShop, animatingDifferences: true)
        }
    }
    
    private var dataSourceError: DataSourceError? {
        didSet {
            if dataSourceError != nil {
                var errorArray = [Error]()
                guard let error = dataSourceError else { return }
                errorArray.append(error)
                // self.coordinator?.pushErrorView(error: errorArray)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = BusStopsViewModel()
        busStops = dataSource.busStops
        dataSource.$arrivalTimes.assign(to: \.arrivalTimes, on: self).store(in: &subscriptions)
        dataSource.$busStops.assign(to: \.busStops, on: self).store(in: &subscriptions)
        dataSource.$dataSourceError.assign(to: \.dataSourceError, on: self).store(in: &subscriptions)
        viewModel?.delegate = self
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCollectionViewlayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.register(BusStopCell.self, forCellWithReuseIdentifier: BusStopCell.reuseIdentifier)
        collectionView.dataSource = collectionViewDataSource
        collectionView.delegate = self
        collectionView.layer.backgroundColor = UIColor.clear.cgColor
        collectionView.frame = CGRect(x: 0, y: 100, width: view.frame.width, height: view.frame.height - 90)
        view.addSubview(collectionView)
        
        refreshButton.backgroundColor = .clear
        refreshButton.setTitle("Press here to update the times", for: .normal)
        refreshButton.layer.borderWidth = 1
        refreshButton.layer.borderColor = UIColor.white.cgColor
        refreshButton.frame = CGRect(x: 20, y: 50, width: view.frame.width - 50, height: 30)
        refreshButton.addTarget(self, action: #selector(BusStopsViewController.pushContentStateView), for: .touchUpInside)
        refreshButton.center.x = view.center.x
        view.addSubview(refreshButton)
        setSourceSetUp()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        coordinator?.childDidFinish(self)
    }
    
    @objc func pushContentStateView() {
        coordinator?.pushContentStateView()
    }
    
    private func setSourceSetUp() {
        collectionViewDataSource = CollectionViewDataSource(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, stop: Stop) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
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

extension BusStopsViewController: Storyboarded {}
extension BusStopsViewController: UICollectionViewDelegateFlowLayout {}

extension BusStopsViewController: MapViewModelDelegate {
    func didUpdateWithData(with stops: [ArrivalTime]) {}
}
