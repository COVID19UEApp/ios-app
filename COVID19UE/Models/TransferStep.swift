//
//  TransferStep.swift
//  COVID19UE
//
//  Created by Linus Geffarth on 26.03.20.
//  Copyright © 2020 Linus Geffarth. All rights reserved.
//

import Foundation

struct TransferStep {
    var index: Int
    var status: Status = .open
    var destination: Location
}

struct Pickup {
    var location: Location
}

extension TransferStep {
    enum Status {
        case open, inProgress, completed
    }
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
