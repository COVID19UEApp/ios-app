//
//  TransferStep1ViewController.swift
//  COVID19UE
//
//  Created by Linus Geffarth on 31.03.20.
//  Copyright © 2020 Linus Geffarth. All rights reserved.
//

import UIKit

class TransferStep1ViewController: TransferStepViewController {
    
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func call() {
        nextButton.isShown = true
        let contact = transfer.currentLocation.contact
        contact.phone?.call { (call) in
            guard let call = call else {
                return self.nextStep()
            }
            guard call.hasEnded else { return }
            if call.hasConnected {
                return self.nextStep()
            } else {
                let alert = UIAlertController(title: "Niemanden erreicht?", message: "Wollen Sie es erneut versuchen, \(contact.name.full) anzurufen?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Erneut anrufen", style: .default) { _ in
                    self.call()
                })
                alert.addAction(UIAlertAction(title: "Abbrechen", style: .cancel))
                self.present(alert, animated: true)
            }
        }
    }
}
