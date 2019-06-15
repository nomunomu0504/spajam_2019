//
//  JSONModel.swift
//  spajam2019-main
//
//  Created by 野村弘樹 on 2019/06/15.
//  Copyright © 2019 Misaki Masashi. All rights reserved.
//

import Foundation

struct _button : Codable  // 選択ボタン
{
    var text : String     // 女の子を喋る言葉
    var rate : Int        // 好感度上昇
    var reply : String    // ボタン押下後の返信
    var face : String     // 応答後の顔画像のパス
    var nextScene : Int   // シーンインデックスの増加度
//    var joy: Float
//    var sadness: Float
//    var anger: Float
}

struct _settings : Codable  // 各種設定
{
    var word : String       // 女の子が喋る言葉
//    var Button : Dictionary<String, [_button]>  // 選択ボタン群
    var Button : [_button]
}

struct _data : Codable              // データ
{
//    var settings : Dictionary<String, _settings>
    var settings: _settings?
//    var settings : _settings     // 各種設定群
    var description : String?        // ナレーション文章
    var backgroundImage : String?    // 背景画像
}

struct JSONData : Codable   // データ群
{
    var Data : [_data]      // データ群
}
