//
//  TransfersMenuViewController.swift
//  COVID19UE
//
//  Created by Linus Geffarth on 26.03.20.
//  Copyright © 2020 Linus Geffarth. All rights reserved.
//

import UIKit
import CoreLocation

class TransfersMenuViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var transfers: [Transfer] = []
    
    var locationManager: CLLocationManager!
    
//    var shouldSegueToTransferSummary: (_ transfer: Transfer) -> Void = { _ in }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard CLLocationManager.locationServicesEnabled() else { return }
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension TransfersMenuViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.last else { return }
//        let userLocation = location.coordinate
        // TODO: get transfers close by
    }
}

extension TransfersMenuViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        transfers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TransferMenuCell,
            let transfer = transfers[safe: indexPath.row] else { return UITableViewCell() }
        cell.populate(for: transfer)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.setSelected(false, animated: true)
//        guard let transfer = (cell as? TransferMenuCell)?.transfer else { return }
//        shouldSegueToTransferSummary(transfer)
    }
}

class TransferMenuCell: UITableViewCell {
    
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var flagIcon: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    var transfer: Transfer!
    
    func populate(for transfer: Transfer) {
        self.transfer = transfer
        
        
        transfer.steps.first?.destination.address.getDistance { (distance) in
            guard let distance = distance else { return }
            switch distance {
            case 0...999:
                self.distanceLabel.text = "\(distance) m"
            default:
                let kmDistance = distance / 1000
                self.distanceLabel.text = "\(kmDistance) km"
            }
        }
    }
}
