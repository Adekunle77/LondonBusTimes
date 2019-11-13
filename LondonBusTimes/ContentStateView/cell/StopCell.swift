//
//  StopCell.swift
//  LondonBusTimes
//
//  Created by Ade Adegoke on 15/10/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import UIKit
import MapKit

class StopCell: UICollectionViewCell {
    static let reuseIdentifier: String = "cell"
    @IBOutlet weak var arrivalTime: UILabel!
    
    @IBOutlet weak var busNumber: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var destination: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundView?.backgroundColor = .lightGray
    }

}
