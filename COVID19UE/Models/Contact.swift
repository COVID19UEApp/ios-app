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
    var phone: PhoneNumber?
    var email: String?
    
    var string: String {
        let str = "\(name.full)\n\((phone?.number).orEmpty)\n\(email.orEmpty)"
        return str.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

struct Name {
    var salutation: String?
    var first: String
    var last: String
    var maiden: String?
    
    var full: String {
        "\(salutation.orEmpty) \(first) \(last)".trimmingCharacters(in: .whitespaces)
    }
}
