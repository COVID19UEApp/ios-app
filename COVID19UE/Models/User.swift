//
//  User.swift
//  COVID19UE
//
//  Created by Linus Geffarth on 26.03.20.
//  Copyright © 2020 Linus Geffarth. All rights reserved.
//

import Foundation

class User {
    
    var email: String
    /// Temporary password used during signup
    var tmpPassword: String?
    
    var contact: Contact?
    
    init(email: String) {
        self.email = email
    }
}
