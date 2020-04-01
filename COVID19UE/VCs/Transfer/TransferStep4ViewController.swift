//
//  TransferStep4ViewController.swift
//  COVID19UE
//
//  Created by Linus Geffarth on 01.04.20.
//  Copyright © 2020 Linus Geffarth. All rights reserved.
//

import UIKit

class TransferStep4ViewController: TransferStepViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func nextStep() {
        performSegue(withID: "TransferStep4_to_TransferCompleted")
    }
}
