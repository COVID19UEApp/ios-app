//
//  Mandate.swift
//  COVID19UE
//
//  Created by Linus Geffarth on 26.03.20.
//  Copyright © 2020 Linus Geffarth. All rights reserved.
//

import Foundation

struct Mandate {
    
    var deceased: Deceased
    
    var contact: Contact?
        
    init(deceased: Deceased) {
        self.deceased = deceased
    }
}

struct Deceased {
    var name: Name
    var birthDate: Date?
    
    var infectiousDisease: String?
    var isContagious: Bool {
        return infectiousDisease?.nonEmpty != nil
    }
}
