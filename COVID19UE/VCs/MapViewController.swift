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
import MapKitGoogleStyler

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
        mapView.register(TransferAnnotationView.self, forAnnotationViewWithReuseIdentifier: "annotation")
        
        styleMap()
    }
    
    func showOnMap(_ transfers: [Transfer]) {
        for transfer in transfers {
            mapView.addAnnotation(TransferAnnotation(transfer: transfer))
//            transfer.pickup.getCoordinate({ (location) in
//                guard let location = location else { return }
//                let distance: Int? = Account.current.user.currentLocation != nil ? Int(location.distance(from: Account.current.user.currentLocation!)) : nil
//                let distanceString = distance != nil ? ((0...999).contains(distance!) ? " (\(distance!) m)" : String(format: " (%.2f km)", Float(distance!) / 1000)) : ""
//
//                let annotation = MKPointAnnotation()
//                annotation.title = "Abholung" + distanceString
//                annotation.subtitle = transfer.mandate.deceased.name.full + ", " + (transfer.mandate.deceased.birthDate?.string(withFormat: "dd.MM.yyyy") ?? "")
//                annotation.coordinate = location.coordinate
//                self.mapView.addAnnotation(annotation)
//            })
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude - 0.006, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04))
        if !hasSetRegion {
            mapView.setRegion(region, animated: true)
            hasSetRegion = true
        }
        
        Account.current.user.currentLocation = location
    }
    
    func styleMap() {
        guard
            let jsonURL = Bundle.main.url(forResource: "gmapsStyles", withExtension: "geojson"),
            let tileOverlay = try? MapKitGoogleStyler.buildOverlay(with: jsonURL) else { return }
        tileOverlay.canReplaceMapContent = true
        mapView.addOverlay(tileOverlay, level: .aboveRoads)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard
            let annotation = annotation as? TransferAnnotation,
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "annotation"),
            let view = Bundle.main.loadNibNamed("TransferAnnotationView", owner: self, options: nil)?.first as? TransferAnnotationView else { return nil }
        annotationView.addSubview(view)
        view.populate(for: annotation.transfer)
        
        return view
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let tileOverlay = overlay as? MKTileOverlay {
            return MKTileOverlayRenderer(tileOverlay: tileOverlay)
        }
        return MKOverlayRenderer(overlay: overlay)
    }
}

fileprivate class TransferAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D()
    
    var transfer: Transfer
    
    init(transfer: Transfer) {
        self.transfer = transfer
        
        super.init()
        
        transfer.currentAddress.getCoordinate { (location) in
            guard let coord = location?.coordinate else { return }
            self.coordinate = coord
        }
    }
}

class TransferAnnotationView: MKAnnotationView {
    
    @IBOutlet weak var leftIconView: UIImageView!
    @IBOutlet weak var rightIconView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var transfer: Transfer!
    
    override var reuseIdentifier: String? {
        get { "annotation" }
    }
    
    func populate(for transfer: Transfer) {
        self.transfer = transfer
        
        let a = transfer.currentAddress
        titleLabel.text = "\(a.street) \(a.house), \(a.city)"
    }
}
