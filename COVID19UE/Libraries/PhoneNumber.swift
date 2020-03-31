//
//  PhoneNumber.swift
//  COVID19UE
//
//  Created by Linus Geffarth on 31.03.20.
//  Copyright © 2020 Linus Geffarth. All rights reserved.
//

import UIKit
import CallKit

class PhoneNumber: NSObject {
    
    var number: String?
    
    var callObserver: CXCallObserver!
    var callFinished: (_ call: CXCall?) -> Void = { _ in }
    
    convenience init?(_ number: String) {
        guard number.is(.phoneNumber) else { return nil }
        self.init()
        
        self.number = number
        
        callObserver = CXCallObserver()
        callObserver.setDelegate(self, queue: nil) // nil queue means main thread
    }
    
    func call(_ finished: @escaping (_ call: CXCall?) -> Void = { _ in }) {
        guard
            let number = number,
            number.is(.phoneNumber),
            let url = URL(string: "tel://\(number.onlyDigits)"),
            UIApplication.shared.canOpenURL(url) else { return finished(nil) }
        UIApplication.shared.open(url, options: [:]) { (success) in
            guard success else {
                // call completion handler when url
                // could not be opened
                return finished(nil)
            }
            self.callFinished = finished
        }
    }
}

extension PhoneNumber: CXCallObserverDelegate {
    func callObserver(_ callObserver: CXCallObserver, callChanged call: CXCall) {
        guard call.isOutgoing else { return }
        callFinished(call)
    }
}
