//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Jan Inge Husby on 16/02/16.
//  Copyright © 2016 Jan Inge Husby. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var mapView: MKMapView!
    let regionRadius: CLLocationDistance = 10
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MapViewController loaded its view")
        
        
    }

    override func loadView() {
        super.loadView()

        mapView = MKMapView()
        mapView.zoomEnabled = true
        mapView.showsUserLocation = true
        
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
        
        view = mapView

        let standardString = NSLocalizedString("Standard", comment: "Standard map view")
        let satelliteString = NSLocalizedString("Satellite", comment: "Satellite map view")
        let hybridString = NSLocalizedString("Hybrid", comment: "Hybrid map view")
        let segmentedControl = UISegmentedControl(items: [standardString, satelliteString, hybridString])
        segmentedControl.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        let topConstraint = segmentedControl.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor, constant: 20)

        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentedControl.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor)
        segmentedControl.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor)
        segmentedControl.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor)
        
        topConstraint.active = true
        leadingConstraint.active = true
        trailingConstraint.active = true
        
        segmentedControl.addTarget(self, action: "mapTypeChanged:", forControlEvents: .ValueChanged)
    }
    
    func mapTypeChanged(segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .Standard
        case 1:
            mapView.mapType = .Hybrid
        case 2:
            mapView.mapType = .Satellite
        default:
            break
        }
    }
    
    
    
}
