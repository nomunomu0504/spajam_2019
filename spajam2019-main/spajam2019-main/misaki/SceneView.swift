//
//  CustomView.swift
//  spajam2019-main
//
//  Created by Misaki Masashi on 2019/06/15.
//  Copyright © 2019 Misaki Masashi. All rights reserved.
//
import UIKit

protocol SceneViewDelegate: class {
    func sceneViewButtonDidTapped(sender: UIButton)
}


class SceneView: UIView {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var backImageView: UIImageView!

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    var buttons: Array<UIButton>!
    var button5: UIButton!
    
    weak var delegate: SceneViewDelegate?
    
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
        label.backgroundColor = .white
        label.layer.borderColor = UIColor(hex: "E9546A").cgColor
        label.layer.borderWidth = 5
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        
        label.frame = CGRect(x: bounds.origin.x + 50,
                             y: bounds.origin.y + 50,
                            width: bounds.width - 50 * 2,
                            height: 60)
        
        buttons = [button1, button2, button3]
        
        var base_y:CGFloat = 150
        for (index, button) in buttons.enumerated() {
            button.frame = CGRect(x: bounds.origin.x + 50, y: (bounds.origin.y + base_y), width: bounds.width - 50 * 2, height: 30)
            base_y += 60
            button.backgroundColor = UIColor.white
            button.backgroundColor = .white
            button.layer.borderColor = UIColor.border().cgColor
            button.layer.borderWidth = 2
            button.layer.cornerRadius = 5
            button.layer.masksToBounds = true
            button.tag = index
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        }

        
    }
    
    @objc func buttonTapped(_ sender: UIButton) { // ボタンがタップされた時に呼ばれる
        delegate?.sceneViewButtonDidTapped(sender: sender)
        
    }
    
    func loadNib() {
        if let view = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? UIView {
            view.frame = self.bounds
            self.addSubview(view)
        }
    }
        
}
