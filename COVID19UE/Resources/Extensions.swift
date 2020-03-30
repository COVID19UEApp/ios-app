//
//  Extensions.swift
//  COVID19UE
//
//  Created by Linus Geffarth on 26.03.20.
//  Copyright © 2020 Linus Geffarth. All rights reserved.
//

import UIKit

extension UIView {
    func pinToSuperview(with insets: UIEdgeInsets = .zero, edges: UIRectEdge = .all) {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        if edges.contains(.top) {
            topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top).isActive = true
        }
        if edges.contains(.bottom) {
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -insets.bottom).isActive = true
        }
        if edges.contains(.left) {
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.left).isActive = true
        }
        if edges.contains(.right) {
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -insets.right).isActive = true
        }
    }
    
    var isShown: Bool {
        get { !isHidden }
        set { isHidden = !newValue }
    }
}

extension UIViewController {
    func performSegue(withID id: String) {
        performSegue(withIdentifier: id, sender: nil)
    }
    
    func addChild(_ child: UIViewController, in containerView: UIView) {
        guard containerView.isDescendant(of: view) else { return }
        addChild(child)
        containerView.addSubview(child.view)
        child.view.pinToSuperview()
        child.didMove(toParent: self)
    }
    
    func removeChild(_ child: UIViewController) {
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
}

public func viewController(withID id: String, from storyboardID: String = "Main") -> UIViewController {
    UIStoryboard(name: storyboardID, bundle: nil).instantiateViewController(withIdentifier: id)
}

extension Collection where Indices.Iterator.Element == Index {
    /// Returns the element at the specified index if it is within bounds, otherwise nil
    subscript (safe index: Index?) -> Iterator.Element? {
        guard let i = index else { return nil }
        return indices.contains(i) ? self[i] : nil
    }
}
extension Collection{
    func sorted<Value: Comparable>(
        by keyPath: KeyPath<Element, Value>,
        _ comparator: (_ lhs: Value, _ rhs: Value) -> Bool) -> [Element] {
        return self.sorted{
            comparator($0[keyPath: keyPath], $1[keyPath: keyPath])
        }
    }
}

extension Array {
    var nonEmpty: Array? {
        return self.count > 0 ? self : nil
    }
}

extension String {
    var nonEmpty: String? {
        return self == "" ? nil : self
    }
}
extension Optional where Wrapped == String {
    var orEmpty: String {
        self ?? ""
    }
}

extension Date {
    func string(withFormat format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

infix operator ???: NilCoalescingPrecedence

public func ???<T>(optional: T?, defaultValue: @autoclosure () -> String) -> String {
    switch optional {
    case let value?: return String(describing: value)
    case nil: return defaultValue()
    }
}
