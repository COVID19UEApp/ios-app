//
//  Transfer.swift
//  COVID19UE
//
//  Created by Linus Geffarth on 26.03.20.
//  Copyright © 2020 Linus Geffarth. All rights reserved.
//

import Foundation

struct Transfer {
    
    var mandate: Mandate
    var pickup: Address
    var steps: [TransferStep] = []
}
