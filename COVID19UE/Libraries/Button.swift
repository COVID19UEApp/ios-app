//
//  Button.swift
//  COVID19UE
//
//  Created by Linus Geffarth on 30.03.20.
//  Copyright © 2020 Linus Geffarth. All rights reserved.
//

import UIKit

@IBDesignable
class Button: UIButton {
    
    func commonInit() {
        titleLabel?.font = UIFont(name: "OpenSans-Semibold", size: 14)
        set(title: title(for: .normal))
        set(titleColor: textColor)
    }
    
    var textColor: UIColor? {
        #if TARGET_INTERFACE_BUILDER
        return .white
        #else
        return UIColor(named: "Light Text")
        #endif
    }
    
    var primaryColor: UIColor? {
        #if TARGET_INTERFACE_BUILDER
        return .black
        #else
        return UIColor(named: "Primary")
        #endif
    }
    
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
}
