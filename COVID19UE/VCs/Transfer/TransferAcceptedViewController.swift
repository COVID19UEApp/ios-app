//
//  TransferAcceptedViewController.swift
//  COVID19UE
//
//  Created by Linus Geffarth on 30.03.20.
//  Copyright © 2020 Linus Geffarth. All rights reserved.
//

import UIKit

class TransferAcceptedViewController: TransferStepViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // disables swipe down to dismiss view controller
        isModalInPresentation = true
    }
    
    override func nextStep() {
        performSegue(withID: "TransferAccepted_to_TransferStep1")
    }
}
