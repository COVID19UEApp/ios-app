//
//  Agent.swift
//  COVID19UE
//
//  Created by Linus Geffarth on 26.03.20.
//  Copyright © 2020 Linus Geffarth. All rights reserved.
//

import Foundation

class Agent: User {
    
    var type: AgentType
    
    init(email: String, type: AgentType) {
        self.type = type
        
        super.init(email: email)
    }
}

extension Agent {
    enum AgentType {
        case hospital
        case retirementHome
        case mobileCareService
        case authority
        case funeralHome
    }
}
