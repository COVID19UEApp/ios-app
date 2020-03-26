//
//  Mandate.swift
//  COVID19UE
//
//  Created by Linus Geffarth on 26.03.20.
//  Copyright © 2020 Linus Geffarth. All rights reserved.
//

import Foundation

struct Mandate {
    
    var deceasedName: (first: String, last: String)
    
    var contact: Contact?
    
    init(deceasedName: (String, String)) {
        self.deceasedName = deceasedName
    }
}
