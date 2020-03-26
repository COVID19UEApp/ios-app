//
//  Account.swift
//  COVID19UE
//
//  Created by Linus Geffarth on 26.03.20.
//  Copyright © 2020 Linus Geffarth. All rights reserved.
//

import Foundation

struct Account {
    
    static var current: Account = Account(user: Vendor(email: "luna@kingsley.com"))
    
    var user: User
}
