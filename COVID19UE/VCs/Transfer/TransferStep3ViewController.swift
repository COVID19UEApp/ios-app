//
//  TransferStep3ViewController.swift
//  COVID19UE
//
//  Created by Linus Geffarth on 01.04.20.
//  Copyright © 2020 Linus Geffarth. All rights reserved.
//

import UIKit
import MapKit

class TransferStep3ViewController: TransferStepViewController {
    
    @IBOutlet weak var primaryButton: PrimaryButton!
    @IBOutlet weak var mapContainerView: UIView!
    
    override var step: Int {
        return 3
    }
    
    var hasCalculatedRoute: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let mapVC = viewController(withID: "MapViewController", from: "Vendor") as? MapViewController else { return }
        addChild(mapVC, in: mapContainerView)
        mapVC.mapRegionOffset = 30
        mapVC.showOnMap([transfer])
    }
    
    override func nextStep() {
        guard hasCalculatedRoute else {
            let address = transfer.currentLocation.address
            address.getCoordinate { (location) in
                guard let coordinate = location?.coordinate else { return }
                let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary: nil))
                mapItem.name = address.institution ?? address.string
                
                guard
                    let url = URL(string: "comgooglemaps://?saddr=&daddr=\(coordinate.latitude),\(coordinate.longitude)&directionsmode=driving"),
                    UIApplication.shared.canOpenURL(url) else {
                        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
                        return
                }
                let alert = UIAlertController(title: "Route öffnen in...", message: nil, preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "Apple Karten", style: .default, handler: { _ in
                    mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
                }))
                alert.addAction(UIAlertAction(title: "Google Maps", style: .default, handler: { _ in
                    UIApplication.shared.open(url)
                }))
                alert.addAction(UIAlertAction(title: "Abbrechen", style: .cancel))
                self.present(alert, animated: true)
            }
            hasCalculatedRoute = true
            primaryButton.set(title: "Weiter")
            return
        }
        super.nextStep()
    }
}
