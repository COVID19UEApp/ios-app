//
//  TransferDetailsViewController.swift
//  COVID19UE
//
//  Created by Linus Geffarth on 30.03.20.
//  Copyright © 2020 Linus Geffarth. All rights reserved.
//

import UIKit

class TransferDetailsViewController: UIViewController {
    
    @IBOutlet weak var deceasedNameLabel: UILabel!
    @IBOutlet weak var warningsView: UIStackView!
    @IBOutlet weak var infectionView: UIStackView!
    @IBOutlet weak var infectionLabel: UILabel!
    @IBOutlet weak var weightView: UIStackView!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var sizeView: UIStackView!
    @IBOutlet weak var sizeLabel: UILabel!
    
    @IBOutlet weak var pickupAddressLabel: UILabel!
    @IBOutlet weak var pickupContactLabel: UILabel!
    
    @IBOutlet weak var dropoffAddressLabel: UILabel!
    @IBOutlet weak var dropoffContactLabel: UILabel!
    
    var transfer: Transfer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    func updateUI() {
        let dec = transfer.mandate.deceased
        
        deceasedNameLabel.text = dec.name.full
        
        warningsView.isShown = dec.isContagious || dec.hasOverweight || dec.hasOversize
        infectionView.isShown = dec.isContagious
        weightView.isShown = dec.hasOverweight
        sizeView.isShown = dec.hasOversize
        
        infectionLabel.text = dec.infectiousDisease
        weightLabel.text = (dec.weight ??? "?") + "kg"
        sizeLabel.text = "b \(dec.width ??? "?") cm, h \(dec.height ??? "?") cm"
        
        pickupAddressLabel.text = transfer.pickup.location.address.string
        pickupContactLabel.text = transfer.pickup.location.contact.string
        
        dropoffAddressLabel.text = transfer.nextDestination?.address.string
        dropoffContactLabel.text = transfer.nextDestination?.contact.string
    }
    
    @IBAction func dismiss() {
        dismiss(animated: true)
    }
}
