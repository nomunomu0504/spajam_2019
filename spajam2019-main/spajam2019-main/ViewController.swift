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

    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView = SceneView()
        sceneView.imageView.image = UIImage(named: "01_ang")
        sceneView.backImageView.image = UIImage(named: "maturi")

        view.addSubview(sceneView)
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }


}

