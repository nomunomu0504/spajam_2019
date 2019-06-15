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
    
    var aitalk : AITalkWebAPI?
    
    init(
        _speaker_name: String = "nozomi_emo",
        _style: String = "{\"j\":\"1.0\"}",
        _input_type: String = "text",
        _text: String,
        _volume: String = "1.0",
        _speed: String = "1.0",
        _pitch: String = "1.0",
        _range: String = "1.0"
    ) {
        self.aitalk = AITalkWebAPI(
            _speaker_name: _speaker_name,
            _style: _style,
            _input_type: _input_type,
            _text: _text,
            _volume: _volume,
            _speed: _speed,
            _pitch: _pitch,
            _range: _range
        )
    }
    
    func text2talk(text: String)
    {
//        self.aitalk = AITalkWebAPI()
        self.aitalk!.text = text
        // aitalk.speaker_name = "nozomi_emo"
        // aitalk.style = "{\"j\":\"1.0\"}"
        
        self.aitalk!.synth(handler: onCompletedSynth)
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
