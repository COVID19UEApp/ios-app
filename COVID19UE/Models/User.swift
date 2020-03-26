//
//  User.swift
//  COVID19UE
//
//  Created by Linus Geffarth on 26.03.20.
//  Copyright © 2020 Linus Geffarth. All rights reserved.
//

import Foundation

class User {
    
    var type: UserType
    
    var email: String
    /// Temporary password used during signup
    var tmpPassword: String?
    
    var contact: Contact?
    
    init(type: UserType, email: String) {
        self.type = type
        self.email = email
    }
}

extension User {
    enum UserType {
        case vendor, agent, authority
    }
}
