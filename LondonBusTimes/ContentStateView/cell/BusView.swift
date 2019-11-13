//
//  BusView.swift
//  LondonBusTimes
//
//  Created by Ade Adegoke on 09/11/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import UIKit

class BusView: UIView {
    let number = UILabel()
    let arrivesIn = UILabel()
    let destinations = UILabel()
    private let separator = UIView(frame: .zero)
    
    func updateNumberText(_ text: String?) {
        guard let text = text else { return }
        number.text = text
    }
    
    func updateDestinationsText(_ text: String?) {
        guard let text = text else { return }
        destinations.text = text
    }
    
    func updateArrivesInText(_ text: String?) {
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
   
        arrivesIn.font = UIFont.preferredFont(forTextStyle: .subheadline)
        arrivesIn.textColor = .label
        arrivesIn.textAlignment = .right
        arrivesIn.translatesAutoresizingMaskIntoConstraints = false
        addSubview(arrivesIn)
        
        number.translatesAutoresizingMaskIntoConstraints = false
        number.font = UIFont.preferredFont(forTextStyle: .subheadline)
        number.textColor = .label
        addSubview(number)
        
        destinations.translatesAutoresizingMaskIntoConstraints = false
        destinations.font = UIFont.preferredFont(forTextStyle: .subheadline)
        destinations.textColor = .secondaryLabel
        addSubview(destinations)
        
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .quaternaryLabel
        addSubview(separator)
        
        let topStackView = UIStackView(arrangedSubviews: [number, arrivesIn])
        topStackView.axis = .horizontal
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(topStackView)
        NSLayoutConstraint.activate([
            topStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            topStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            topStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10)
        ])
        
        let bottomStackView = UIStackView(arrangedSubviews: [destinations])
        bottomStackView.axis = .vertical
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bottomStackView)
        NSLayoutConstraint.activate([
          //  separator.heightAnchor.constraint(equalToConstant: 1),
            bottomStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomStackView.topAnchor.constraint(equalTo: topStackView.bottomAnchor),
            bottomStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
