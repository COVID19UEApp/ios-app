//
//  Vendor.swift
//  COVID19UE
//
//  Created by Linus Geffarth on 26.03.20.
//  Copyright © 2020 Linus Geffarth. All rights reserved.
//

import Foundation

class Vendor: User {
    
    var type: VendorType = .transferrer
}

extension Vendor {
    enum VendorType {
        case transferrer
    }
}
