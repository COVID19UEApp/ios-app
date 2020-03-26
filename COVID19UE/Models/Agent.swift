//
//  Agent.swift
//  COVID19UE
//
//  Created by Linus Geffarth on 26.03.20.
//  Copyright © 2020 Linus Geffarth. All rights reserved.
//

import Foundation

class Agent: User {
    
    var serviceType: AgentServiceType
    
    init(email: String, serviceType: AgentServiceType) {
        self.serviceType = serviceType
        
        super.init(type: .agent, email: email)
    }
}

extension Agent {
    enum AgentServiceType {
        case hospital
        case retirementHome
        case mobileCareService
        case authority
        case funeralHome
    }
}
