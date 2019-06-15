//
//  ViewController.swift
//  spajam2019-main
//
//  Created by Misaki Masashi on 2019/06/15.
//  Copyright © 2019 Misaki Masashi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var sceneView: SceneView!

    var ImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // sceneの作成
        sceneView = SceneView(frame: self.view.frame)
        sceneView.imageView.image = UIImage(named: "01_ang")
        sceneView.backImageView.image = UIImage(named: "maturi")
        sceneView.delegate = self

        view.addSubview(sceneView)
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }


}


extension ViewController: SceneViewDelegate {
    func sceneViewButtonDidTapped(sender: UIButton) {
        // sceneviewのbuttonがタップされた時に呼ばれる
        print(sender.tag) // buttonのid 上から0
    }
}
