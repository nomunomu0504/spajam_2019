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
    func sceneLabelTapped(sender: UITapGestureRecognizer)
    func start(sender: UIButton)
}


class SceneView: UIView {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    var _view: UIView!
    
    @IBAction func labelTapped(_ sender: UITapGestureRecognizer) {
        let _instance = buttonSelector(frame: CGRect(x: 0, y: 290, width: 375, height: 295))
        delegate?.sceneLabelTapped(sender: sender)
        _instance.buttonsTitles = buttonsTitles
        _view = _instance.selectorView()

        
        self.addSubview(_view)
    }
    
    
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var speachButton: UIButton!
    
    
    var buttons: Array<UIButton>!
    var buttonsTitles: Array<String>! = ["a", "b", "c"]
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
        
        self.bringSubviewToFront(label)
        label.textColor = UIColor.white()
//        label.backgroundColor = .white
//        label.layer.borderColor = UIColor(hex: "E9546A").cgColor
//        label.layer.borderWidth = 5
//        label.layer.cornerRadius = 10
//        label.layer.masksToBounds = true
        
//        label.frame = CGRect(x: bounds.origin.x + 50,
//                             y: bounds.origin.y + 50,
//                            width: bounds.width - 50 * 2,
//                            height: 60)

//        backImageView.frame = CGRect(x: bounds.origin.x + 10,
//                                     y: bounds.origin.y + 250,
//                                     width: bounds.width - 10 * 2,
//                                     height: 300)
//        imageView.frame =  CGRect(x: bounds.origin.x + 40,
//                                 y: bounds.origin.y + 350,
//                                 width: bounds.width - 30 * 2,
//                                 height: 500)
        
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
    @IBAction func onStart(_ sender: UIButton) {
        delegate?.start(sender: sender)
    }
    
}

extension SceneView: buttonSelectorDelegate {
    func buttonTapped(sender: UIButton) {
        print("tapped")
    }
}
