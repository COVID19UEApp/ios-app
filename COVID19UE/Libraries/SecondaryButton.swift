//
//  SecondaryButton.swift
//  COVID19UE
//
//  Created by Linus Geffarth on 30.03.20.
//  Copyright © 2020 Linus Geffarth. All rights reserved.
//

import UIKit

@IBDesignable
class SecondaryButton: UIButton {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        commonInit()
    }
    
    override func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title?.uppercased(), for: state)
    }
    
    func commonInit() {
        setTitle(title(for: .normal), for: .normal)
        setTitleColor(UIColor(named: "Light Gray Text"), for: .normal)
        titleLabel?.font = UIFont(name: "OpenSans", size: 13)
    }
}

