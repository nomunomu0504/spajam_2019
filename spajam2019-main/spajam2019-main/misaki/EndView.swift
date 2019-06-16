//
//  EndView.swift
//  spajam2019-main
//
//  Created by Misaki Masashi on 2019/06/16.
//  Copyright © 2019 Misaki Masashi. All rights reserved.
//

import Foundation
import UIKit

class EndView: UIView {
    
    
    
    @IBAction func OnClick(_ sender: UIButton) {
        sender.sizeToFit()
        sender.frame = CGRect(x: self.bounds.origin.x + 50, y: self.bounds.origin.y + 100,
                              width: self.bounds.width - 50 * 2 , height: self.bounds.height / 2)
        sender.titleLabel?.font =  UIFont.systemFont(ofSize: 30)
        sender.titleLabel?.numberOfLines = 2
        sender.setTitle("おめでとう！！成功しました", for: .normal)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        loadNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
      
    }

    func loadNib() {
        if let view = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? UIView {
            view.frame = self.bounds
            self.addSubview(view)
        }
    }
    
}
