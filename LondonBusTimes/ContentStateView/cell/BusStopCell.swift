//
//  BusStopCell.swift
//  LondonBusTimes
//
//  Created by Ade Adegoke on 23/10/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import UIKit
import MapKit

class BusStopCell: UICollectionViewCell {
    static let reuseIdentifier: String = "cell"
    private var viewModel = BusStopCellModel()
    private var didSetupConstraints = false
    private let busStopView = BusStopView()
    private let secondBusView = BusView()
    private let thirdBusView = BusView()
    private let map = MKMapView()
    
    override func prepareForReuse() {
        super.prepareForReuse()
      map.removeAnnotations(map.annotations)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
        map.delegate = self
        map.isZoomEnabled = false
        self.map.isScrollEnabled = false
        self.map.isUserInteractionEnabled = false
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 5.0
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
    }
    
    func updateCell(with stopInfo: Stop, coordinates: Coordinate) {
        self.busStopView.updateLabels(with: stopInfo)
        if stopInfo.buses.count > 1 {
            secondBusView.updateNextBusLabels(with: stopInfo.buses[1])
       }
        
        if stopInfo.buses.count > 2 {
            secondBusView.updateLastBusLabels(with: stopInfo.buses[2])
        }

        viewModel.getDirections(startCoordinates: coordinates, finishInfo: stopInfo, mapView: self.map)
    }
    
    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
        //map.alpha = 1
    }

    private func setupMyLabel() {

        busStopView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(busStopView)
        secondBusView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(secondBusView)
        thirdBusView.translatesAutoresizingMaskIntoConstraints = false
        map.translatesAutoresizingMaskIntoConstraints = false
        map.isScrollEnabled = false
        map.clipsToBounds = true
        contentView.addSubview(map)
     }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not happening")
    }
    
    func setup() {
        setupMyLabel()
        contentView.setNeedsUpdateConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
    }
    
    override func updateConstraints() {
           if didSetupConstraints == false {
               addConstraintsForMyLabel()
           }
           super.updateConstraints()
       }

        private func addConstraintsForMyLabel() {
        busStopView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        busStopView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        busStopView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        busStopView.bottomAnchor.constraint(equalTo: secondBusView.topAnchor).isActive = true
        
        secondBusView.topAnchor.constraint(equalTo: busStopView.bottomAnchor).isActive = true
        secondBusView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        secondBusView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        secondBusView.bottomAnchor.constraint(equalTo: map.topAnchor).isActive = true
        
        map.topAnchor.constraint(equalTo: secondBusView.bottomAnchor).isActive = true
        map.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        map.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        map.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
       }
}

extension BusStopCell: MKMapViewDelegate, UIPopoverPresentationControllerDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.strokeColor = .systemBlue
        return renderer
    }
}

extension Int {
    func changeToMinutes() -> String {
        if self < 60 {
            return "Due"
        }
        return "\(self / 60) mins"
    }
}
