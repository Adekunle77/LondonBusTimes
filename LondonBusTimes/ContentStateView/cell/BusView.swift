//
//  BusView.swift
//  LondonBusTimes
//
//  Created by Ade Adegoke on 09/11/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import UIKit

class BusView: UIView {
    let nextBusNumber = UILabel()
    let nextBusArrivesIn = UILabel()
    let nextBusDestinations = UILabel()
    
    let lastBusNumber = UILabel()
    let lastBusArrivesIn = UILabel()
    let lastBusDestinations = UILabel()
    
    private let separator = UIView(frame: .zero)
    
    func updateNextBusLabels(with busData: Bus) {
        self.nextBusNumber.text = busData.busNumber
        self.nextBusDestinations.text = busData.destination
        self.nextBusArrivesIn.text = busData.arrivalTime.changeToMinutes()
    }
    
    func updateLastBusLabels(with busData: Bus) {
        self.lastBusNumber.text = busData.busNumber
        self.lastBusDestinations.text = busData.destination
        self.lastBusArrivesIn.text = busData.arrivalTime.changeToMinutes()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewSetup()
    }
    
    private func viewSetup() {
   
        nextBusArrivesIn.font = UIFont.preferredFont(forTextStyle: .subheadline)
        nextBusArrivesIn.textColor = .label
        nextBusArrivesIn.textAlignment = .right
        nextBusArrivesIn.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nextBusArrivesIn)
        
        nextBusNumber.translatesAutoresizingMaskIntoConstraints = false
        nextBusNumber.font = UIFont.preferredFont(forTextStyle: .subheadline)
        nextBusNumber.textColor = .label
        addSubview(nextBusNumber)
        
        nextBusDestinations.translatesAutoresizingMaskIntoConstraints = false
        nextBusDestinations.font = UIFont.preferredFont(forTextStyle: .subheadline)
        nextBusDestinations.textColor = .secondaryLabel
        addSubview(nextBusDestinations)
        
        lastBusArrivesIn.font = UIFont.preferredFont(forTextStyle: .subheadline)
        lastBusArrivesIn.textColor = .label
        lastBusArrivesIn.textAlignment = .right
        lastBusArrivesIn.translatesAutoresizingMaskIntoConstraints = false
        addSubview(lastBusArrivesIn)
        
        lastBusNumber.translatesAutoresizingMaskIntoConstraints = false
        lastBusNumber.font = UIFont.preferredFont(forTextStyle: .subheadline)
        lastBusNumber.textColor = .label
        addSubview(lastBusNumber)
        
        lastBusDestinations.translatesAutoresizingMaskIntoConstraints = false
        lastBusDestinations.font = UIFont.preferredFont(forTextStyle: .subheadline)
        lastBusDestinations.textColor = .secondaryLabel
        addSubview(lastBusDestinations)
        
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .quaternaryLabel
        addSubview(separator)
        
        let topStackView = UIStackView(arrangedSubviews: [nextBusNumber, nextBusArrivesIn])
        topStackView.axis = .horizontal
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(topStackView)
        NSLayoutConstraint.activate([
            topStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            topStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            topStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
        ])
        
        let middleStackView = UIStackView(arrangedSubviews: [nextBusDestinations])
        middleStackView.axis = .vertical
        middleStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(middleStackView)
        NSLayoutConstraint.activate([
           separator.heightAnchor.constraint(equalToConstant: 1),
            
            middleStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            middleStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            middleStackView.topAnchor.constraint(equalTo: topStackView.bottomAnchor),
        ])
        
        let thirdStackView = UIStackView(arrangedSubviews: [lastBusNumber, lastBusArrivesIn])
           thirdStackView.axis = .horizontal
           thirdStackView.translatesAutoresizingMaskIntoConstraints = false
           addSubview(thirdStackView)
           NSLayoutConstraint.activate([
               thirdStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
               thirdStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
               thirdStackView.topAnchor.constraint(equalTo: middleStackView.bottomAnchor, constant: 10)
           ])
           
            let bottomStackView = UIStackView(arrangedSubviews: [lastBusDestinations])
            bottomStackView.axis = .vertical
            bottomStackView.translatesAutoresizingMaskIntoConstraints = false
            bottomStackView.spacing = 10
            addSubview(bottomStackView)
            NSLayoutConstraint.activate([
               bottomStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
               bottomStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
               bottomStackView.topAnchor.constraint(equalTo: thirdStackView.bottomAnchor),
               bottomStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
           ])
        
        
    }
}
