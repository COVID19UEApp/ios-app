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
    
    /// Returns the current address of the deceased body.
    /// If a step is open or in progress, the start point of that step is returned.
    /// If no step has been completed, the pickup address of the transfer will be used.
    var currentAddress: Address {
        for (i, step) in steps.sorted(by: \.index, <).enumerated() {
            if [.open, .inProgress].contains(step.status) {
                if let previousStep = steps[safe: i-1] {
                    return previousStep.destination.address
                } else {
                    return pickup
                }
            }
            // last step, completed
            if i == steps.count - 1 {
                return step.destination.address
            }
        }
        return pickup
    }
}
