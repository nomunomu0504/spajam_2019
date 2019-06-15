//
//  UIView+NibInstantiatable.swift
//  spajam2019-main
//
//  Created by 野村弘樹 on 2019/06/15.
//  Copyright © 2019 Misaki Masashi. All rights reserved.
//

import Foundation
import UIKit

public protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

public extension ClassNameProtocol {
    static var className: String {
        return String(describing: self)
    }
    
    var className: String {
        return type(of: self).className
    }
}

extension NSObject: ClassNameProtocol {}
//
//import Foundation
//
//public protocol NibInstantiatable {
//    static var nibName: String { get }
//    static var nibBundle: Bundle { get }
//    static var nibOwner: Any? { get }
//    static var nibOptions: [UINib.OptionsKey: Any]? { get }
//    static var instantiateIndex: Int { get }
//}
//
//public extension NibInstantiatable where Self: NSObject {
//    static var nibName: String { return className }
//    static var nibBundle: Bundle { return Bundle(for: self) }
//    static var nibOwner: Any? { return self }
//    static var nibOptions: [UINib.OptionsKey: Any]? { return nil }
//    static var instantiateIndex: Int { return 0 }
//}
//
//public extension NibInstantiatable where Self: UIView {
//    static func instantiate() -> Self {
//        let nib = UINib(nibName: nibName, bundle: nibBundle)
//        return nib.instantiate(withOwner: nibOwner, options: nibOptions).first as! Self
//    }
//}

