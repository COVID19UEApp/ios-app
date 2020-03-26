//
//  LoginStep1ViewController.swift
//  COVID19UE
//
//  Created by Linus Geffarth on 26.03.20.
//  Copyright © 2020 Linus Geffarth. All rights reserved.
//

import UIKit

class LoginStep1ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func login() {
        // Login_to_Agent, Login_to_Vendor
        switch Account.current.user.type {
        case .agent:
            performSegue(withID: "Login_to_Agent")
        case .vendor:
            performSegue(withID: "Login_to_Vendor")
        default:
            break
        }
    }
    
    @IBAction func register() {
        
    }
}
