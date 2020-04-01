//
//  TransferCompletedViewController.swift
//  COVID19UE
//
//  Created by Linus Geffarth on 01.04.20.
//  Copyright © 2020 Linus Geffarth. All rights reserved.
//

import UIKit

class TransferCompletedViewController: TransferStepViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func nextStep() { /* no next step, as this is the last one */ }
    
    @IBAction override func dismiss() {
        navigationController?.dismiss(animated: true)
    }
}
