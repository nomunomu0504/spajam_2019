//
//  PreConfessionViewController.swift
//  spajam2019-main
//
//  Created by 野村弘樹 on 2019/06/15.
//  Copyright © 2019 Misaki Masashi. All rights reserved.
//

import UIKit

class PreConfessionViewController: UIViewController {
    
    var sceneView: SceneView!
    var ImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // sceneの作成
        sceneView = SceneView(frame: self.view.frame)
        sceneView.imageView.image = UIImage(named: "01_ang")
        sceneView.backImageView.image = UIImage(named: "maturi")
        sceneView.delegate = self
        
        view.addSubview(sceneView)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PreConfessionViewController: SceneViewDelegate {
    func sceneViewButtonDidTapped(sender: UIButton) {
        // sceneviewのbuttonがタップされた時に呼ばれる
        print(sender.tag) // buttonのid 上から0
        if let viewWithTag = self.view.viewWithTag(999) {
            viewWithTag.removeFromSuperview()
        } else{
            print("No!")
        }
    }
    
}

