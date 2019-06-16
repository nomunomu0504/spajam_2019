//
//  PreConfessionViewController.swift
//  spajam2019-main
//
//  Created by 野村弘樹 on 2019/06/15.
//  Copyright © 2019 Misaki Masashi. All rights reserved.
//

import UIKit
import Speech

class PreConfessionViewController: UIViewController {
    
    var sceneView: SceneView!
    var ImageView: UIImageView!
    
    var aiTalk: AITalk!
    
    var buttonsData: JSONData!
    
    var sceneCounter = 0
    
    var repFlag = false
    
    var dataLength = 0
    
    var tag = 0
    
    var globalResult = ""
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ja-JP"))!
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        requestRecognizerAuthorization()
    }
    
    private func requestRecognizerAuthorization() {
        // 認証処理
        SFSpeechRecognizer.requestAuthorization { authStatus in
            // メインスレッドで処理したい内容のため、OperationQueue.main.addOperationを使う
            OperationQueue.main.addOperation { [weak self] in
                guard let `self` = self else { return }
                print(authStatus)
            }
        }
    }
    
    private func startRecording() throws {
        refreshTask()
        
        let audioSession = AVAudioSession.sharedInstance()
        // 録音用のカテゴリをセット
        try audioSession.setCategory(AVAudioSession.Category.record)
        try audioSession.setMode(AVAudioSession.Mode.measurement)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        let inputNode = audioEngine.inputNode
        guard let recognitionRequest = recognitionRequest else { fatalError("Unable to created a SFSpeechAudioBufferRecognitionRequest object") }
        
        // 録音が完了する前のリクエストを作るかどうかのフラグ。
        // trueだと現在-1回目のリクエスト結果が返ってくる模様。falseだとボタンをオフにしたときに音声認識の結果が返ってくる設定。
        recognitionRequest.shouldReportPartialResults = true
        
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { [weak self] result, error in
            guard let `self` = self else { return }
            
            var isFinal = false
            
            if let result = result {
                print(result.bestTranscription.formattedString)
                self.globalResult = result.bestTranscription.formattedString
                isFinal = result.isFinal
            }
            
            // エラーがある、もしくは最後の認識結果だった場合の処理
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                Thread.sleep(forTimeInterval: 2)
                try! audioSession.setCategory(AVAudioSession.Category.ambient)
                try! audioSession.setMode(AVAudioSession.Mode.default)
                try! audioSession.setActive(true)
                
            }
        }
        
        // マイクから取得した音声バッファをリクエストに渡す
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            self.recognitionRequest?.append(buffer)
        }
        
        try startAudioEngine()
    }
    
    private func refreshTask() {
        if let recognitionTask = recognitionTask {
            recognitionTask.cancel()
            self.recognitionTask = nil
        }
    }
    
    private func startAudioEngine() throws {
        // startの前にリソースを確保しておく。
        audioEngine.prepare()
        
        try audioEngine.start()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        speechRecognizer.delegate = self
        
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
        sceneView.delegate = self
        
        dataLength = buttonsData.Data.count

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
            print(description)
        }
        //
        if let background = buttonsData.Data[sceneCounter].backgroundImage {
            sceneView.backImageView.image = UIImage(named: background)
        }
        
        
        sceneCounter += 1
        
        
        view.addSubview(sceneView)
        

    }
    
    func getJSONDataStory() throws -> Data? {
        guard let path = Bundle.main.path(forResource: "story2", ofType: "json") else { return nil }
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
    
    func start(sender: UIButton) {
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
//            button.isEnabled = false
//            button.setTitle("停止中", for: .disabled)
            
            if let buttons  = buttonsData.Data[sceneCounter-1].settings?.Button {
                for (index, button) in buttons.enumerated() {
//                    print("2 button text" + button.text)
                    if globalResult == button.text {
                        buttonClick(sender_tag: index)
                    }
//                    sceneView.buttonsTitles[index] = button.text
                }
            }

        } else {
            try! startRecording()
//            button.setTitle("音声認識を中止", for: [])
        }
    }
    
    func sceneLabelTapped(sender: UITapGestureRecognizer) {
        if repFlag {
            
            
            if let chara = buttonsData.Data[sceneCounter-1].settings?.Button[tag].face {
                if chara != "" {
                    sceneView.imageView.image = UIImage(named: chara)
                }
            }
            
            if let buttons  = buttonsData.Data[sceneCounter].settings?.Button {
                for (index, button) in buttons.enumerated() {
                    print("1 button text" + button.text)
                    sceneView.buttonsTitles[index] = button.text
                }
            }
            
            
            if let description = buttonsData.Data[sceneCounter].description {
                //            sceneView.description = description
            }
            //
            if let background = buttonsData.Data[sceneCounter].backgroundImage {
                sceneView.backImageView.image = UIImage(named: background)
            }

            if let unwrapped = buttonsData.Data[sceneCounter].settings?.word {
                print(unwrapped)
                sceneView.label.text = unwrapped
                aiTalk.text2talk(text: unwrapped)
            }
            
            
            repFlag = false
            sceneCounter += 1
            if sceneCounter-1 >= buttonsData.Data.count-1 {
                let endView = EndView(frame: self.view.frame)
                view.addSubview(endView)
                return
            }
        }
    }
    
    func buttonClick(sender_tag: Int) {
        // sceneviewのbuttonがタップされた時に呼ばれる
//        print(sender.tag) // buttonのid 上から0
        tag = sender_tag
        if sceneCounter-1 >= buttonsData.Data.count-1 {
            let endView = EndView(frame: self.view.frame)
            view.addSubview(endView)
            return
        }
        
        if let rep = buttonsData.Data[sceneCounter-1].settings?.Button[sender_tag].reply {
            print(rep)
            if rep != "" {
                sceneView.label.text = rep
                aiTalk.text2talk(text: rep)
                repFlag = true
            }
        }
        
        if repFlag == false {
            
            if let chara = buttonsData.Data[sceneCounter-1].settings?.Button[sender_tag].face {
                if chara != "" {
                    sceneView.imageView.image = UIImage(named: chara)
                }
            }
            
            if let unwrapped = buttonsData.Data[sceneCounter].settings?.word {
                print(unwrapped)
                sceneView.label.text = unwrapped
                aiTalk.text2talk(text: unwrapped)
            }
            
            if let buttons  = buttonsData.Data[sceneCounter].settings?.Button {
                for (index, button) in buttons.enumerated() {
                    print("2 button text" + button.text)
                    sceneView.buttonsTitles[index] = button.text
                }
            }
            
            if let viewWithTag = self.view.viewWithTag(999) {
                print("view with tag")
                viewWithTag.removeFromSuperview()
            } else{
                print("No!")
                
            }
            
            
            
            if let description = buttonsData.Data[sceneCounter].description {
                //            sceneView.description = description
            }
            //
            if let background = buttonsData.Data[sceneCounter].backgroundImage {
                sceneView.backImageView.image = UIImage(named: background)
            }
            
            sceneCounter += 1
            if sceneCounter-1 >= buttonsData.Data.count-1 {
                let endView = EndView(frame: self.view.frame)
                view.addSubview(endView)
                return
            }
            
        }
        
        print("ここにきたよ")
        if let viewWithTag = self.view.viewWithTag(999) {
            print("view with tag")
            viewWithTag.removeFromSuperview()
        } else{
            print("No!")
            
        }
        
    }
    
    func sceneViewButtonDidTapped(sender: UIButton) {
       
        buttonClick(sender_tag: sender.tag)
        
        
    }
    
}

extension PreConfessionViewController: SFSpeechRecognizerDelegate {
    // 音声認識の可否が変更したときに呼ばれるdelegate
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            print("onsei start")
        } else {
            print("onsei stop")
            
        }
    }
}
