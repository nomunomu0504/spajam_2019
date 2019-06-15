//
//  UIcolor+hex.swift
//  spajam2019-main
//
//  Created by Misaki Masashi on 2019/06/15.
//  Copyright © 2019 Misaki Masashi. All rights reserved.
//

import UIKit

/*
 view.backgroundColor = UIColor(hex: "59C5BF")
 こんな感じで使う
 https://note.mu/tiekey/n/nf1152c5daebf
 */

extension UIColor {
    convenience init(hex: String, alpha: CGFloat) {
        let v = hex.map { String($0) } + Array(repeating: "0", count: max(6 - hex.count, 0))
        let r = CGFloat(Int(v[0] + v[1], radix: 16) ?? 0) / 255.0
        let g = CGFloat(Int(v[2] + v[3], radix: 16) ?? 0) / 255.0
        let b = CGFloat(Int(v[4] + v[5], radix: 16) ?? 0) / 255.0
        self.init(red: r, green: g, blue: b, alpha: min(max(alpha, 0), 1))
    }
    
    convenience init(hex: String) {
        self.init(hex: hex, alpha: 1.0)
    }
    
    class func title() -> UIColor {
        return UIColor(hex: "424242")
    }
    
    class func description() -> UIColor {
        return UIColor(hex: "757575")
    }
    
    class func border() -> UIColor {
        return UIColor(hex: "e0e0e0")
    }
}
