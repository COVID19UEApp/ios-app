//
//  TransferStep.swift
//  COVID19UE
//
//  Created by Linus Geffarth on 26.03.20.
//  Copyright © 2020 Linus Geffarth. All rights reserved.
//

import Foundation

class SuperTransferStep {
    var status: TransferStepStatus = .open
    
    init(status: TransferStepStatus) {
        self.status = status
    }
}

class TransferStep: SuperTransferStep {
    var index: Int
    var destination: Location
    
    init(index: Int, status: TransferStepStatus = .open, destination: Location) {
        self.index = index
        self.destination = destination
        
        super.init(status: status)
    }
}

class Pickup: SuperTransferStep {
    var location: Location

    init(status: TransferStepStatus = .open, location: Location) {
        self.location = location
        
        super.init(status: status)
    }
}

enum TransferStepStatus {
    case open, inProgress, completed
}


struct Location {
    var type: LocationType
    var address: Address
    var contact: Contact
}

extension Location {
    enum LocationType {
        case deathplace
        case funeralHome
        case cooling
        case pathology
        case crematory
        case finalRestingPlace
        
        case other
    }
}
