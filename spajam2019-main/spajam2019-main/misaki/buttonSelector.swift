//
//  buttonSelector.swift
//  spajam2019-main
//
//  Created by 野村弘樹 on 2019/06/15.
//  Copyright © 2019 Misaki Masashi. All rights reserved.
//

import Foundation
import UIKit

protocol buttonSelectorDelegate: class {
    func buttonTapped(sender: UIButton)
}

class buttonSelector : UIView {
    
    weak var delegate: buttonSelectorDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    @objc func buttonTapped(_ sender: UIButton) { // ボタンがタップされた時に呼ばれる
        delegate?.buttonTapped(sender: sender)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    var overlayView = UIView()
    
    var buttonsTitles: Array<String>! = ["a", "b", "c"]
    
    func selectorView() -> UIView {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        overlayView.frame = CGRect(x: 0, y: 290, width: 375, height: 295)
        overlayView.center = CGPoint(x: appDelegate.window!.frame.width / 2.0, y: appDelegate.window!.frame.height / 2.0)
        overlayView.backgroundColor = UIColor.init(hex: "000", alpha: 0.5)
        overlayView.tag = 999
        
        let y_offset: CGFloat = 77
        let buttonTop = UIButton(frame: CGRect(x: 37, y: 50, width: 302, height: 30))
        let buttonCenter = UIButton(frame: CGRect(x: 37, y: 50 + y_offset, width: 302, height: 30))
        let buttonBottom = UIButton(frame: CGRect(x: 37, y: 50 + y_offset * 2, width: 302, height: 30))
        
        let buttons = [buttonTop, buttonCenter, buttonBottom]
        
        for (index, button) in buttons.enumerated() {
            button.backgroundColor = UIColor.white
            button.backgroundColor = .white
            button.layer.borderColor = UIColor.border().cgColor
            button.layer.borderWidth = 2
            button.layer.cornerRadius = 5
            button.layer.masksToBounds = true
            button.tag = index
            button.setTitle(buttonsTitles[index], for: .normal)
//            button.tintColor = UIColor.red
            button.setTitleColor(UIColor.description(), for: .normal)
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            overlayView.addSubview(button)
        }
        
        return overlayView
    }
    
    func loadNib() -> UIView? {
        var res : UIView? = nil
        if let view = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? UIView {
            view.frame = self.bounds
            res = view
        }
        return res
    }
}
