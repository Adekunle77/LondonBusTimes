//
//  BusStopView.swift
//  LondonBusTimes
//
//  Created by Ade Adegoke on 09/11/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import UIKit

class BusStopView: UIView {

    private let stopName = UILabel()
    private let fristbusNumber = UILabel()
    private let firstBusDestinations = UILabel()
    private let firstBusArrivesIn = UILabel()
    private let separator = UIView(frame: .zero)

    func updateLabels(with stopData: Stop) {
        self.stopName.text = stopData.stopName
        self.fristbusNumber.text = stopData.buses.first?.busNumber
        self.firstBusDestinations.text = stopData.buses.first?.destination
        guard let arrivalTime = stopData.buses.first?.arrivalTime else { return }
        self.firstBusArrivesIn.text = arrivalTime.changeToMinutes()
    }
    
    override init(frame: CGRect) {
      super.init(frame: frame)
        viewSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewSetup()
    }
    
    func viewSetup() {

        stopName.translatesAutoresizingMaskIntoConstraints = false
        stopName.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 12, weight: .bold))
        stopName.textColor = .systemBlue
        self.addSubview(stopName)
        
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .quaternaryLabel
        self.addSubview(separator)
        
        firstBusArrivesIn.font = UIFont.preferredFont(forTextStyle: .title2)
        firstBusArrivesIn.textColor = .label
        firstBusArrivesIn.textAlignment = .right
        firstBusArrivesIn.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(firstBusArrivesIn)
        
        fristbusNumber.translatesAutoresizingMaskIntoConstraints = false
        fristbusNumber.font = UIFont.preferredFont(forTextStyle: .title2)
        fristbusNumber.textColor = .label
        self.addSubview(fristbusNumber)
        
        firstBusDestinations.translatesAutoresizingMaskIntoConstraints = false
        firstBusDestinations.font = UIFont.preferredFont(forTextStyle: .callout)
        firstBusDestinations.textColor = .secondaryLabel
        self.addSubview(firstBusDestinations)
        
        let busStopStackView = UIStackView(arrangedSubviews: [stopName, separator])
        busStopStackView.axis = .vertical
        busStopStackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(busStopStackView)
        
        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 1),
            busStopStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            busStopStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            busStopStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        busStopStackView.setCustomSpacing(8, after: stopName)
        busStopStackView.setCustomSpacing(10, after: separator)
        
        fristbusNumber.topAnchor.constraint(equalTo: busStopStackView.bottomAnchor, constant: 5).isActive = true
        fristbusNumber.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        fristbusNumber.trailingAnchor.constraint(equalTo: firstBusArrivesIn.leadingAnchor).isActive = true

        firstBusArrivesIn.topAnchor.constraint(equalTo: busStopStackView.bottomAnchor, constant: 5).isActive = true
        firstBusArrivesIn.leadingAnchor.constraint(equalTo: fristbusNumber.trailingAnchor).isActive = true
        firstBusArrivesIn.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
       
        let bottomStackView = UIStackView(arrangedSubviews: [firstBusDestinations])
        bottomStackView.axis = .vertical
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bottomStackView)
        
        NSLayoutConstraint.activate([
            bottomStackView.topAnchor.constraint(equalTo: fristbusNumber.bottomAnchor),
            bottomStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])        
    }
}

