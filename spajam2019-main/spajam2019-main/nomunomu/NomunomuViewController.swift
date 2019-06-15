//
//  NomunomuViewController.swift
//  spajam2019-main
//
//  Created by 野村弘樹 on 2019/06/15.
//  Copyright © 2019 Misaki Masashi. All rights reserved.
//

import UIKit
import AVFoundation

class NomunomuViewController: UIViewController, AVAudioPlayerDelegate {
    
    var aitalk : AITalk?
    
    @IBOutlet weak var talkText: UITextField!
    @IBAction func playButton(_ sender: Any) {
        self.aitalk!.text2talk(text: talkText.text!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.aitalk = AITalk()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = (UINib(nibName: "NomunomuView", bundle: nibBundle).instantiate(withOwner: self, options: nil).first as! UIView)
        // Do any additional setup after loading the view.
    }
    
    
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */

}
