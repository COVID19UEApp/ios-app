//
//  TransferStepViewController.swift
//  COVID19UE
//
//  Created by Linus Geffarth on 31.03.20.
//  Copyright © 2020 Linus Geffarth. All rights reserved.
//

import UIKit

class TransferStepViewController: UIViewController {

    var transfer: Transfer! 
    
    var step: Int {
        1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func nextStep() {
        performSegue(withID: "TransferStep\(step)_to_TransferStep\(step + 1)")
    }
    
    @IBAction func dismiss() {
        navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let dest = segue.destination as? TransferStepViewController {
            dest.transfer = transfer
        }
    }
}
