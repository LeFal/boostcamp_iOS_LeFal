//
//  MapViewController.swift
//  week2_book_ch5_ViewController
//
//  Created by LEOFALCON on 2017. 7. 10..
//  Copyright © 2017년 LeFal. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    var mapView : MKMapView!
    let locationManager = CLLocationManager()

    override func loadView() {
        mapView = MKMapView()
        view = mapView
        
        let segmentControl = UISegmentedControl(items: ["Standard","Hybrid","Satellite"])
        segmentControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentControl.selectedSegmentIndex = 0
        
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentControl)
        
        let topConstraint = segmentControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8)
        
        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
    
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true

        segmentControl.addTarget(self, action: #selector(mapTypeChanged(segControl:)), for: .valueChanged)
    }
    
    func mapTypeChanged(segControl: UISegmentedControl){
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
    
    func requestLocationAccess() {
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            return
            
        case .denied, .restricted:
            print("location access denied")
            
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        print("MapViewController loaded its view.")
        mapView.showsUserLocation = true
        requestLocationAccess()
        locationManager.startUpdatingLocation()
        let locValue: CLLocationCoordinate2D = locationManager.location!.coordinate
        let span = MKCoordinateSpanMake(0.050, 0.050)
        let region = MKCoordinateRegion(center: locValue, span: span)
        mapView.setRegion(region, animated: true)
        
        let pin = MKPointAnnotation()
        pin.coordinate = CLLocationCoordinate2D(latitude: 11.12, longitude: 12.11)
        mapView.addAnnotation(pin)
        //
    }
}
