//
//  TransferAcceptedViewController.swift
//  COVID19UE
//
//  Created by Linus Geffarth on 30.03.20.
//  Copyright © 2020 Linus Geffarth. All rights reserved.
//

import UIKit

class TransferAcceptedViewController: UIViewController {
    
    var transfer: Transfer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func nextStep() {
        performSegue(withID: "TransferAccepted_to_TransferStep1")
    }
    
    @IBAction func dismiss() {
        navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let dest = segue.destination as? TransferDetailsViewController {
            dest.transfer = transfer
        }
    }
}
