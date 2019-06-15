//
//  AITalk.swift
//  spajam2019-main
//
//  Created by 野村弘樹 on 2019/06/15.
//  Copyright © 2019 Misaki Masashi. All rights reserved.
//

import Foundation
import AVFoundation

class AITalk : NSObject, AVAudioPlayerDelegate {
    
    var _player : AVAudioPlayer? = nil  // 再生プレイヤー
    private let FILENAME = "talking.mp3"
    
    func text2talk(text: String)
    {
        var aitalk = AITalkWebAPI()
        aitalk.text = text
        // aitalk.speaker_name = "nozomi_emo"
        // aitalk.style = "{\"j\":\"1.0\"}"
        
        aitalk.synth(handler: onCompletedSynth)
    }
    
    // 再生完了イベントハンドラ
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully: Bool) {
        return
    }
    
    func onCompletedSynth(data: Data?, res:URLResponse?, err:Error?) -> Void {
        if err != nil { return }
        
        let _res = res as! HTTPURLResponse
        if _res.statusCode != 200 { return }
        
        //　ファイルの出力先URL
        let savedir = NSSearchPathForDirectoriesInDomains(
            .documentDirectory,
            .userDomainMask, true)[0] as String
        let output_file = "file://" + savedir + "/" + self.FILENAME
        let url : URL! = URL(string:output_file)!
        
        // ファイル保存
        do {
            try data!.write(to:url)
        } catch { return }
        
        //　音声再生準備
        do {
            self._player = try AVAudioPlayer(contentsOf:url)
            self._player!.delegate = self
            self._player!.numberOfLoops = 0
            self._player!.prepareToPlay()
            self._player!.play()
        } catch { return }
    }
}
