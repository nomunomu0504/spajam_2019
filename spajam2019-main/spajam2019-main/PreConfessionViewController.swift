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
    
    var aiTalk: AITalk!
    
    var buttonsData: JSONData!
    
    var sceneCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let StoryData = try? getJSONDataStory() else {
            print("error1")
            return
        }
        
        guard let buttonsData = try? JSONDecoder().decode(JSONData.self, from: StoryData) else {
            print("error end")
            return
        }
        
        self.buttonsData = buttonsData
        

        
        
        aiTalk = AITalk()

        // Do any additional setup after loading the view.
        // sceneの作成
        sceneView = SceneView(frame: self.view.frame)
        sceneView.imageView.image = UIImage(named: "01_ang")
//        sceneView.backImageView.image = UIImage(named: "maturi")
        sceneView.delegate = self
        

        if let unwrapped = buttonsData.Data[sceneCounter].settings?.word {
            print(unwrapped)
            sceneView.label.text = unwrapped
            aiTalk.text2talk(text: unwrapped)
        }

        if let buttons  = buttonsData.Data[sceneCounter].settings?.Button {
            for (index, button) in buttons.enumerated() {
                print("button text" + button.text)
                sceneView.buttonsTitles[index] = button.text
            }
        }


        if let description = buttonsData.Data[sceneCounter].description {
            //            sceneView.description = description
        }
        //

        if let text = buttonsData.Data[sceneCounter].backgroundImage {
            sceneView.backImageView.image = UIImage(named: text)
        }
        
        
        sceneCounter += 1
        
        
        view.addSubview(sceneView)
        

    }
    
    func getJSONDataStory() throws -> Data? {
        guard let path = Bundle.main.path(forResource: "story", ofType: "json") else { return nil }
        let url = URL(fileURLWithPath: path)
        return try Data(contentsOf: url)
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
        
        if let unwrapped = buttonsData.Data[sceneCounter].settings?.word {
            print(unwrapped)
            sceneView.label.text = unwrapped
            aiTalk.text2talk(text: unwrapped)
        }
        
        if let buttons  = buttonsData.Data[sceneCounter].settings?.Button {
            for (index, button) in buttons.enumerated() {
                print("button text" + button.text)
                sceneView.buttonsTitles[index] = button.text
            }
        }
        
        
        if buttonsData.Data[sceneCounter].description != nil {
            //            sceneView.description = description
        }
        //
        
        if let background = buttonsData.Data[sceneCounter].backgroundImage {
            sceneView.backImageView.image = UIImage(named: background)
        }
        
        
        sceneCounter += 1
        
        
        if let viewWithTag = self.view.viewWithTag(999) {
            viewWithTag.removeFromSuperview()
        } else{
            print("No!")
        }
    }
    
}

