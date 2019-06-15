//
//  ViewController.swift
//  spajam2019-main
//
//  Created by Misaki Masashi on 2019/06/15.
//  Copyright © 2019 Misaki Masashi. All rights reserved.
//


import UIKit

struct Animal: Codable {
    let park: String
    let animals: [String]
    let nickname: Dictionary<String, String>
}

class ViewController: UIViewController {

    var sceneView: SceneView!

    var aiTalk: AITalk!

    var buttonsData: JSONData!

    var sceneCounter = 0

    var ImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        aiTalk = AITalk()
        // sceneの作成
        sceneView = SceneView(frame: self.view.frame)
        sceneView.imageView.image = UIImage(named: "01_ang")
        sceneView.backImageView.image = UIImage(named: "maturi")
        sceneView.delegate = self

        view.addSubview(sceneView)

        aiTalk.text2talk(text: "こんにちはー世界")


        guard let StoryData = try? getJSONDataStory() else {
            print("error1")
            return
        }

        guard let buttonsData = try? JSONDecoder().decode(JSONData.self, from: StoryData) else {
            print("error end")
            return
        }

        self.buttonsData = buttonsData

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }


    func getJSONDataStory() throws -> Data? {
        guard let path = Bundle.main.path(forResource: "test3", ofType: "json") else { return nil }
        let url = URL(fileURLWithPath: path)
        return try Data(contentsOf: url)
    }



}


extension ViewController: SceneViewDelegate {

    func sceneViewButtonDidTapped(sender: UIButton) {
        // sceneviewのb uttonがタップされた時に呼ばれる
        print(sender.tag) // buttonのid 上から0

        if let unwrapped = buttonsData.Data[sceneCounter].settings?.word {
            print(unwrapped)
            sceneView.label.text = unwrapped
            aiTalk.text2talk(text: unwrapped)
        }

        if let buttons  = buttonsData.Data[sceneCounter].settings?.Button {
            for (index, button) in buttons.enumerated() {
                sceneView.buttons[index].setTitle(button.text, for: .normal)
            }
        }


        if let description = buttonsData.Data[sceneCounter].description {
//            sceneView.description = description
        }
//
        if let background = buttonsData.Data[sceneCounter].backgroundImage {
            sceneView.backImageView.image = UIImage(named: background)
        }


        sceneCounter += 1
    }
}
