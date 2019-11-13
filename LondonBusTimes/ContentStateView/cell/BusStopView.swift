//
//  BusStopView.swift
//  LondonBusTimes
//
//  Created by Ade Adegoke on 09/11/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import UIKit

class BusStopView: UIView {

    private let name = UILabel()
    private let number = UILabel()
    private let destinations = UILabel()
    private let arrivesIn = UILabel()
    private let separator = UIView(frame: .zero)
    private let separatorTwo = UIView(frame: .zero)
    func updateNameText(_ text:String?) {
        guard let text = text else { return }
        name.text = text
    }
    
    func updateNumberText(_ text:String?) {
        guard let text = text else { return }
        number.text = text
    }
    
    func updateDestinationsText(_ text:String?) {
        guard let text = text else { return }
        destinations.text = text
    }
    
    func updateArrivesInText(_ text:String?) {
        guard let text = text else { return }
        arrivesIn.text = text
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

        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 12, weight: .bold))
        name.textColor = .systemBlue
        self.addSubview(name)
        
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .quaternaryLabel
        self.addSubview(separator)
        
        arrivesIn.font = UIFont.preferredFont(forTextStyle: .title2)
        arrivesIn.textColor = .label
        arrivesIn.textAlignment = .right
        arrivesIn.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(arrivesIn)
        
        number.translatesAutoresizingMaskIntoConstraints = false
        number.font = UIFont.preferredFont(forTextStyle: .title2)
        number.textColor = .label
        self.addSubview(number)
        
        destinations.translatesAutoresizingMaskIntoConstraints = false
        destinations.font = UIFont.preferredFont(forTextStyle: .callout)
        destinations.textColor = .secondaryLabel
        self.addSubview(destinations)
        
        separatorTwo.translatesAutoresizingMaskIntoConstraints = false
        separatorTwo.backgroundColor = .quaternaryLabel
        self.addSubview(separatorTwo)
        
        let busStopStackView = UIStackView(arrangedSubviews: [name, separator])
        busStopStackView.axis = .vertical
        busStopStackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(busStopStackView)
        
        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 1),
            busStopStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            busStopStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            busStopStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        busStopStackView.setCustomSpacing(8, after: name)
        busStopStackView.setCustomSpacing(10, after: separator)
        
        number.topAnchor.constraint(equalTo: busStopStackView.bottomAnchor, constant: 5).isActive = true
        number.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        number.trailingAnchor.constraint(equalTo: arrivesIn.leadingAnchor).isActive = true

        arrivesIn.topAnchor.constraint(equalTo: busStopStackView.bottomAnchor, constant: 5).isActive = true
        arrivesIn.leadingAnchor.constraint(equalTo: number.trailingAnchor).isActive = true
        arrivesIn.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
//        destinations.topAnchor.constraint(equalTo: number.bottomAnchor, constant: 2).isActive = true
//        destinations.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
//        destinations.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
//        destinations.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
       
        let bottomStackView = UIStackView(arrangedSubviews: [destinations, separatorTwo])
        bottomStackView.axis = .vertical
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bottomStackView)
        
        NSLayoutConstraint.activate([
            separatorTwo.heightAnchor.constraint(equalToConstant: 1),
            bottomStackView.topAnchor.constraint(equalTo: number.bottomAnchor, constant: 5),
            bottomStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])        
    }
    
}
