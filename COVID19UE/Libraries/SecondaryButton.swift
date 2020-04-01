//
//  SecondaryButton.swift
//  COVID19UE
//
//  Created by Linus Geffarth on 01.04.20.
//  Copyright © 2020 Linus Geffarth. All rights reserved.
//

import UIKit

class SecondaryButton: PrimaryButton {
    
    override func commonInit() {
        super.commonInit()
        
        backgroundColor = .clear
        layer.borderWidth = 2
        layer.borderColor = primaryColor?.cgColor
    }
    
    override var textColor: UIColor? {
        primaryColor
    }
}
