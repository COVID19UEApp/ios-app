//
//  TertiaryButton.swift
//  COVID19UE
//
//  Created by Linus Geffarth on 30.03.20.
//  Copyright © 2020 Linus Geffarth. All rights reserved.
//

import UIKit

class TertiaryButton: Button {
        
    override func commonInit() {
        super.commonInit()
        
    }
    
    override var textColor: UIColor? {
        #if TARGET_INTERFACE_BUILDER
        return .lightGray
        #else
        return UIColor(named: "Light Gray Text")
        #endif
    }
}
