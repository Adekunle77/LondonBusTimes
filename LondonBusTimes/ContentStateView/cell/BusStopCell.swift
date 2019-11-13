//
//  BusStopCell.swift
//  LondonBusTimes
//
//  Created by Ade Adegoke on 23/10/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import UIKit
import MapKit

class BusStopCell: UICollectionViewCell, MKMapViewDelegate {
    static let reuseIdentifier: String = "cell"
    
    private weak var viewModel: BusStopCellModel?
    private var didSetupConstraints = false
    
    let busStopView = BusStopView()
    let secondBusView = BusView()
    let thirdBusView = BusView()
    let map = MKMapView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
        map.delegate = self
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 5.0
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
    }
    
    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {

    }

    private func setupMyLabel() {
        map.translatesAutoresizingMaskIntoConstraints = false
        map.isScrollEnabled = false
        map.clipsToBounds = true
        contentView.addSubview(map)

        busStopView.translatesAutoresizingMaskIntoConstraints = false
        busStopView.updateNameText("Hall Place")
        busStopView.updateNumberText("200")
        busStopView.updateArrivesInText("5 minutes")
        busStopView.updateDestinationsText("Destination")
        //busStopView.backgroundColor = .green
        contentView.addSubview(busStopView)
        
        secondBusView.translatesAutoresizingMaskIntoConstraints = false
        secondBusView.updateNumberText("200")
        secondBusView.updateArrivesInText("5 minutes")
        secondBusView.updateDestinationsText("Destination")
        //secondBusView.addBorder(to: .bottom, with: UIColor.gray.cgColor, thickness: 2)
        contentView.addSubview(secondBusView)
        
        thirdBusView.translatesAutoresizingMaskIntoConstraints = false
        thirdBusView.updateNumberText("200")
        thirdBusView.updateArrivesInText("5 minutes")
        thirdBusView.updateDestinationsText("Destination")
       // thirdBusView.addBorder(to: .bottom, with: UIColor.gray.cgColor, thickness: 2)
        contentView.addSubview(thirdBusView)
        
     }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not happening")
    }
    func setup() {
        //contentView.translatesAutoresizingMaskIntoConstraints = false
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
        
        secondBusView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        secondBusView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        secondBusView.bottomAnchor.constraint(equalTo: thirdBusView.topAnchor).isActive = true
        
        thirdBusView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        thirdBusView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        map.topAnchor.constraint(equalTo: thirdBusView.bottomAnchor).isActive = true
        map.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        map.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        map.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
       }
}
