//
//  Contact.swift
//  COVID19UE
//
//  Created by Linus Geffarth on 26.03.20.
//  Copyright © 2020 Linus Geffarth. All rights reserved.
//

import Foundation

struct Contact {
    var name: Name
    var phone: String?
    var email: String?
}

struct Name {
    var salutation: String?
    var first: String
    var last: String
    var maiden: String?
    
    var full: String {
        first + " " + last
    }
}
