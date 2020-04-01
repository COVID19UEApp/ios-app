//
//  PrimaryButton.swift
//  COVID19UE
//
//  Created by Linus Geffarth on 01.04.20.
//  Copyright © 2020 Linus Geffarth. All rights reserved.
//

import UIKit

class PrimaryButton: Button {
    
    override func commonInit() {
        super.commonInit()
                
        backgroundColor = primaryColor
        
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        widthAnchor.constraint(greaterThanOrEqualToConstant: 200).isActive = true
        heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
}
