//
//  BusStopCellModel.swift
//  LondonBusTimes
//
//  Created by Ade Adegoke on 30/10/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import CoreLocation
import Foundation
import MapKit

typealias mapCoordinates = (userLocation: Coordinate, stopLocation: Coordinate)

class BusStopCellModel {
//    private var locationService: LocationService?
//    var usersCurrentCoordinates: Coordinate?
//    private var dataSource = DataSource()
//    
//    init() {
//        self.locationService = LocationService(coordinates: { result in
//            self.usersCurrentCoordinates = result
//            print(result, "BusStopCellModel")
//        })
//    }
//    
    func centerMapOnLocation(location: CLLocation, mapView: MKMapView) {
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
        DispatchQueue.main.async {
            mapView.setRegion(region, animated: true)
        }
    }
    
    func addAnnonations(mapView: MKMapView, busStopInfo: Stop, userLocation: Coordinate) {
        
        mapView.showsUserLocation = true
        let annotation = MKPointAnnotation()
        annotation.title = busStopInfo.stopName
        annotation.coordinate = CLLocationCoordinate2D(latitude: busStopInfo.lat, longitude: busStopInfo.long)
       
       
        mapView.showsBuildings = true
        //let clloction = CLLocation(latitude: 51.40264, longitude: -0.17165)
       // self.centerMapOnLocation(location: clloction, mapView: mapView)
        //self.setMapFocus(mapView: mapView)
        mapView.addAnnotation(annotation)
        
    }
    
    
    func setMapFocus(mapView: MKMapView, coordinates: mapCoordinates) {
        
        let mKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: coordinates.userLocation.latitude, longitude: coordinates.userLocation.longitude), latitudinalMeters: coordinates.stopLocation.latitude, longitudinalMeters: coordinates.stopLocation.longitude)
        
      //  let region = MKCoordinateRegion(center: CLLocation(latitude: 51.40264, longitude: -0.17165), latitudinalMeters: 500, longitudinalMeters: 500)
     //   mapView.setRegion(mapView.regionThatFits(region), animated: true)
    }
    
   // private func zoomMap
    
    func getDirections(startCoordinates: Coordinate, finishInfo: Stop, mapView: MKMapView) {
        let startPlacemark = self.convertCoordinates(with: startCoordinates)
        let finishCoordinates: Coordinate = (finishInfo.lat, finishInfo.long)
       let finishPlacemark = self.convertCoordinates(with: finishCoordinates)
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: startPlacemark)
        request.destination = MKMapItem(placemark: finishPlacemark)
        request.transportType = .walking
        request.requestsAlternateRoutes = false
        let direction = MKDirections(request: request)
        
        direction.calculate(completionHandler: { response, error in
            guard let response = response else {
                if let error = error {
                 
                }
                return
            }
            
            guard let route = response.routes.first else { return }
            let startlocatoion = CLLocation(latitude: startCoordinates.latitude,
                                            longitude: startCoordinates.longitude)
            let finishlocatoion = CLLocation(latitude: finishCoordinates.latitude,
                                            longitude: finishCoordinates.longitude)
            let sourcePlacemark = MKPlacemark(coordinate: startlocatoion.coordinate, addressDictionary: nil)
            let destinationPlacemark = MKPlacemark(coordinate: finishlocatoion.coordinate, addressDictionary: nil)
            let sourceAnnotation = MKPointAnnotation()
            if let location = sourcePlacemark.location {
                sourceAnnotation.coordinate = location.coordinate
            }
            let destinationAnnotation = MKPointAnnotation()
            if let location = destinationPlacemark.location {
                destinationAnnotation.coordinate = location.coordinate
            }
            mapView.addAnnotation(destinationAnnotation)
           // mapView.showsUserLocation = true
            mapView.showsBuildings = true
            mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50), animated: false)
        })
    }
    
    func createDirectionRequest(startCoordinates: Coordinate, finishCoordinates: Coordinate) -> MKDirections.Request {
        let startPlacemark = self.convertCoordinates(with: startCoordinates)
        let finishPlacemark = self.convertCoordinates(with: finishCoordinates)
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: startPlacemark)
        request.destination = MKMapItem(placemark: finishPlacemark)
        request.transportType = .walking
        request.requestsAlternateRoutes = false
        return request
    }
    
    private func convertCoordinates(with coordinates: Coordinate) -> MKPlacemark {
        let latitude = CLLocationDegrees(coordinates.latitude)
        let longitude = CLLocationDegrees(coordinates.longitude)
        let location = CLLocation(latitude: latitude, longitude: longitude).coordinate
        let placemark = MKPlacemark(coordinate: location)
        return placemark
    }
}
