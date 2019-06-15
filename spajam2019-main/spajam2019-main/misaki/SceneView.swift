//
//  CustomView.swift
//  spajam2019-main
//
//  Created by Misaki Masashi on 2019/06/15.
//  Copyright © 2019 Misaki Masashi. All rights reserved.
//
import UIKit

class SceneView: UIView {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var backImageView: UIImageView!
    
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
        
        label.textColor = UIColor.description()
    }
    
    func loadNib() {
        if let view = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? UIView {
            view.frame = self.bounds
            self.addSubview(view)
        }
    }
}
