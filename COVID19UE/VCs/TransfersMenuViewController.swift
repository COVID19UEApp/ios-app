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
    
    let mandate1 = Mandate(deceased: Deceased(name: Name(first: "Luna", last: "Kingsley"), birthDate: Date(), infectiousDisease: "COVID-19"))
    let mandate2 = Mandate(deceased: Deceased(name: Name(first: "Peter", last: "Müller"), birthDate: Date()))
    var transfers: [Transfer] = []
    
    var locationManager: CLLocationManager!
    
    var showOnMap: (_ transfers: [Transfer]) -> Void = { _ in }
    
    var shouldShowTransferDetails: (_ transfer: Transfer) -> Void = { _ in }

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
        
        transfers = [
            Transfer(mandate: mandate1,
                     pickup: Pickup(location: Location(type: .deathplace, address: Address(street: "Reilstr.", house: "128", zip: "06114", city: "Halle", country: "Deutschland"), contact: Contact(name: Name(first: "Linus", last: "Geffarth"), phone: "0179 265 4018", email: "linus@geffarth.de"))),
                     steps: [
                TransferStep(index: 0, status: .open, destination: Location(type: .cooling, address: Address(street: "Hermannstr.", house: "29", zip: "06108", city: "Halle", country: "Deutschland"), contact: Contact(name: Name(first: "Linus", last: "Geffarth"), phone: "0179 265 4018", email: "linus@geffarth.de"))),
                TransferStep(index: 1, status: .open, destination: Location(type: .crematory, address: Address(street: "Burgstr.", house: "65", zip: "06114", city: "Halle", country: "Deutschland"), contact: Contact(name: Name(first: "Peter", last: "Müller"), phone: "0151 192 13291", email: "pmueller@krema-halle.de")))
            ]),
            Transfer(mandate: mandate2,
                     pickup: Pickup(location: Location(type: .deathplace, address: Address(street: "Trothaer Str.", house: "9", zip: "06118", city: "Halle", country: "Deutschland"), contact: Contact(name: Name(first: "Linus", last: "Geffarth"), phone: "0179 265 4018", email: "linus@geffarth.de"))),
                     steps: [
                TransferStep(index: 0, status: .open, destination: Location(type: .cooling, address: Address(street: "Blumenstr.", house: "19", zip: "06108", city: "Halle", country: "Deutschland"), contact: Contact(name: Name(first: "Linus", last: "Geffarth"), phone: "0179 265 4018", email: "linus@geffarth.de"))),
                TransferStep(index: 1, status: .open, destination: Location(type: .crematory, address: Address(street: "Mühlweg", house: "65", zip: "06114", city: "Halle", country: "Deutschland"), contact: Contact(name: Name(first: "Peter", last: "Müller"), phone: "0151 192 13291", email: "pmueller@krema-halle.de")))
            ])
        ]
        showOnMap(transfers)
        tableView.reloadData()
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
        guard let transfer = (cell as? TransferMenuCell)?.transfer else { return }
        shouldShowTransferDetails(transfer)
    }
}

class TransferMenuCell: UITableViewCell {
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var deceasedLabel: UILabel!
    @IBOutlet weak var warningView: UIStackView!
    
    var transfer: Transfer!
    
    func populate(for transfer: Transfer) {
        self.transfer = transfer
        
        deceasedLabel.text = transfer.mandate.deceased.name.full + ", " + (transfer.mandate.deceased.birthDate?.string(withFormat: "dd.MM.yyyy") ?? "")
        warningView.isShown = transfer.mandate.deceased.isContagious
        
        transfer.currentAddress.getDistance { (distance) in
            guard let distance = distance else { return }
            switch distance {
            case 0...999:
                self.distanceLabel.text = "\(distance) m"
            default:
                let kmDistance = Float(distance) / 1000
                self.distanceLabel.text = String(format: "%.2f km", kmDistance)
            }
        }
    }
}
