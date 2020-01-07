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
        map.isZoomEnabled = true
        
        self.map.isScrollEnabled = false
        self.map.isUserInteractionEnabled = false
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 5.0
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
    }
    
    func updateCell(with stopInfo: Stop, coordinates: Coordinate) {
        if map.isUserLocationVisible == false {
            //return
        }
        
        
        self.busStopView.updateLabels(with: stopInfo)
        if stopInfo.buses.count > 1 {
            secondBusView.updateNextBusLabels(with: stopInfo.buses[1])
       }
        
        if stopInfo.buses.count > 2 {
            secondBusView.updateLastBusLabels(with: stopInfo.buses[2])
        }
      //  self.map.showsUserLocation = true
        viewModel.addAnnonations(mapView: self.map, busStopInfo: stopInfo, userLocation: coordinates)
        //self.map.showAnnotations(self.map.annotations, animated: true)
        self.zoomToFitMapAnnotations(map: self.map)
//        var zoomRect = MKMapRect.null
//        let myLocationPointRect = MKMapRect(x: coordinates.longitude, y: coordinates.latitude, width: 100, height: 100)
//        let currentDestinationPointRect = MKMapRect(x: stopInfo.long, y: stopInfo.lat, width: 100, height: 100)
//
//        zoomRect = myLocationPointRect
//        zoomRect = zoomRect.union(currentDestinationPointRect)
//        self.map.setVisibleMapRect(zoomRect, animated: true)
        
        
//        let region = MKCoordinateRegion(center: map.userLocation.coordinate, latitudinalMeters: 100, longitudinalMeters: 500)
//        self.map.setRegion(map.regionThatFits(region), animated: true)
        
       // viewModel.getDirections(startCoordinates: coordinates, finishInfo: stopInfo, mapView: self.map)
    }
    
    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
        map.showsUserLocation = true
    }

    func zoomToFitMapAnnotations(map:MKMapView)
    {
        if(map.annotations.count == 0)
        {
              return
        }

        var topLeftCoord = CLLocationCoordinate2D(latitude: -190, longitude: 380)

        var bottomRightCoord = CLLocationCoordinate2D(latitude: 190, longitude: -380)


        map.annotations.forEach {

            topLeftCoord.longitude = fmin(topLeftCoord.longitude, $0.coordinate.longitude)
            topLeftCoord.latitude = fmax(topLeftCoord.latitude, $0.coordinate.latitude)

            bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, $0.coordinate.longitude)
            bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, $0.coordinate.latitude)
        }

        let resd = CLLocationCoordinate2D(latitude: topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5, longitude: topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5)

        let span = MKCoordinateSpan(latitudeDelta: fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * 1.3, longitudeDelta: fabs(bottomRightCoord.longitude - topLeftCoord.longitude) * 1.3)

        var region = MKCoordinateRegion(center: resd, span: span)

        region = map.regionThatFits(region)

        map.setRegion(region, animated: true)


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
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }

        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }

        return annotationView
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

//extension MKMapView {
//    /// when we call this function, we have already added the annotations to the map, and just want all of them to be displayed.
//    func fitAll() {
//        var zoomRect            = MKMapRect.null;
//        for annotation in annotations {
//            let annotationPoint = MKMapPoint(annotation.coordinate)
//            let pointRect       = MKMapRect(x: annotationPoint.x, y: annotationPoint.y, width: 0.01, height: 0.01);
//            zoomRect            = zoomRect.union(pointRect);
//        }
//        setVisibleMapRect(zoomRect, edgePadding: UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100), animated: true)
//    }
//
//    /// we call this function and give it the annotations we want added to the map. we display the annotations if necessary
//    func fitAll(in annotations: [MKAnnotation], andShow show: Bool) {
//        var zoomRect:MKMapRect  = MKMapRect.null
//
//        for annotation in annotations {
//            let aPoint          = MKMapPoint(annotation.coordinate)
//            let rect            = MKMapRect(x: aPoint.x, y: aPoint.y, width: 0.1, height: 0.1)
//
//            if zoomRect.isNull {
//                zoomRect = rect
//            } else {
//                zoomRect = zoomRect.union(rect)
//            }
//        }
//        if(show) {
//            addAnnotations(annotations)
//        }
//        setVisibleMapRect(zoomRect, edgePadding: UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100), animated: true)
//    }
//
//}
