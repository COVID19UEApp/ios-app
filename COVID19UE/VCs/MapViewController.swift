//
//  MapViewController.swift
//  COVID19UE
//
//  Created by Linus Geffarth on 26.03.20.
//  Copyright © 2020 Linus Geffarth. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager: CLLocationManager!
    
    /// Determines whether the region has been set for the first time.
    var hasSetRegion: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    func showOnMap(_ transfers: [Transfer]) {
        for transfer in transfers {
            transfer.pickup.getCoordinate({ (location) in
                guard let location = location else { return }
                let distance: Int? = Account.current.user.currentLocation != nil ? Int(location.distance(from: Account.current.user.currentLocation!)) : nil
                let distanceString = distance != nil ? ((0...999).contains(distance!) ? " (\(distance!) m)" : String(format: " (%.2f km)", Float(distance!) / 1000)) : ""
                
                let annotation = MKPointAnnotation()
                annotation.title = "Abholung" + distanceString
                annotation.subtitle = transfer.mandate.deceased.name.full + ", " + (transfer.mandate.deceased.birthDate?.string(withFormat: "dd.MM.yyyy") ?? "")
                annotation.coordinate = location.coordinate
                self.mapView.addAnnotation(annotation)
            })
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude - 0.003, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
        if !hasSetRegion {
            mapView.setRegion(region, animated: true)
            hasSetRegion = true
        }
        
        Account.current.user.currentLocation = location
    }
}

extension MapViewController: MKMapViewDelegate {
    
}
