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
    func canPerformSegue(withIdentifier id: String) -> Bool {
        guard let segues = self.value(forKey: "storyboardSegueTemplates") as? [NSObject] else { return false }
        return segues.first { $0.value(forKey: "identifier") as? String == id } != nil
    }
    
    func performSegue(withID id: String) {
        guard canPerformSegue(withIdentifier: id) else {
            print("WARNING: no segue found for identifier '\(id)' – performSegue(withID:), Extensions.swift")
            return
        }
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
    
    /// Determines whether the string (self) conforms to the regex pattern passed, `ignoringCase` is `true` by default
    func conforms(toPattern pattern: String, ignoringCase: Bool = true) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: ignoringCase ? [.caseInsensitive] : []) else { return false }
        let matches = regex.firstMatch(in: self, options: [], range: NSMakeRange(0, utf16.count))
        return matches != nil
    }
    
    enum ContentType {
        case email
        case empty
        case number
        case url
        case phoneNumber
    }
    func `is`(_ contentType: ContentType) -> Bool {
        var pattern = ""
        switch contentType {
        case .email:
            pattern = #"^[a-z0-9](\.?[a-z0-9_-]){0,}@([a-z0-9-]+\.){1,2}([a-z]{1,6}\.)?[a-z]{2,6}$"#
        case .empty:
            pattern = #"^$"#
        case .number:
            pattern = #"^\d+$"#
        case .url:
            pattern = #"^(?:http(s)?:\/\/)?[\w.-]+(?:\.[\w\.-]+)+[\w\-\._~:/?#\[\]@!\$&'\(\)\*\+,;=.]+$"#
        case .phoneNumber:
            pattern = #"^\s*(?:\+?(\d{1,3}))?([-. (]*(\d{3})[-. )]*)?((\d{3})[-. ]*(\d{2,4})(?:[-.x ]*(\d+))?)\s*$"#
        }
        return self.conforms(toPattern: pattern, ignoringCase: true)
    }
    
    var onlyDigits: String {
        let filtredUnicodeScalars = unicodeScalars.filter { CharacterSet.decimalDigits.contains($0) }
        return String(String.UnicodeScalarView(filtredUnicodeScalars))
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

extension Bool {
    var not: Bool {
        !self
    }
}
