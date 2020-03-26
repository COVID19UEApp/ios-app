//
//  Extensions.swift
//  COVID19UE
//
//  Created by Linus Geffarth on 26.03.20.
//  Copyright © 2020 Linus Geffarth. All rights reserved.
//

import UIKit

extension UIViewController {
    func performSegue(withID id: String) {
        performSegue(withIdentifier: id, sender: nil)
    }
}
