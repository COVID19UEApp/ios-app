//
//  Vendor.swift
//  COVID19UE
//
//  Created by Linus Geffarth on 26.03.20.
//  Copyright © 2020 Linus Geffarth. All rights reserved.
//

import Foundation

class Vendor: User {
    
    var serviceType: VendorServiceType = .transferrer
    
    init(email: String, serviceType: VendorServiceType = .transferrer) {
        self.serviceType = serviceType
        
        super.init(type: .vendor, email: email)
    }
}

extension Vendor {
    enum VendorServiceType {
        case transferrer
    }
}
