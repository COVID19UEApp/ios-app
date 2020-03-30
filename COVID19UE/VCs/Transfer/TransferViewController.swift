//
//  TransferViewController.swift
//  COVID19UE
//
//  Created by Linus Geffarth on 30.03.20.
//  Copyright © 2020 Linus Geffarth. All rights reserved.
//

import UIKit

class TransferViewController: UIViewController {
    
    var transfer: Transfer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func acceptTransfer() {
        performSegue(withID: "Transfer_to_TransferAccepted")
    }
    
    @IBAction func showDetails() {
        performSegue(withID: "Transfer_to_TransferDetails")
    }
    
    @IBAction func dismiss() {
        dismiss(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let dest = segue.destination as? TransferDetailsViewController {
            dest.transfer = transfer
        }
        if let dest = segue.destination as? TransferAcceptedViewController {
            dest.transfer = transfer
        }
    }
}
