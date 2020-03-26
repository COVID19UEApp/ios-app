//
//  TransferStep.swift
//  COVID19UE
//
//  Created by Linus Geffarth on 26.03.20.
//  Copyright © 2020 Linus Geffarth. All rights reserved.
//

import Foundation

struct TransferStep {
    
    var mandate: Mandate
    
    var index: Int
    var status: Status = .open
    var destination: Destination
}

extension TransferStep {
    enum Status {
        case open, inProgress, closed
    }
    
    struct Destination {
        var type: DestinationType
        var address: Address
        var contact: Contact
    }
}

extension TransferStep.Destination {
    enum DestinationType {
        case funeralHome
        case cooling
        case pathology
        case finalRestingPlace
        
        case other
    }
}
