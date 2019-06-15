//
//  JSONModel.swift
//  spajam2019-main
//
//  Created by 野村弘樹 on 2019/06/15.
//  Copyright © 2019 Misaki Masashi. All rights reserved.
//

import Foundation

// 選択肢データ
struct _button : Codable {
    let text : String
    let rate : Double
}

// 女の子設定
struct womanSetting : Codable {
    let word : String           // 女の子が喋るセリフ
    let button : [_button]   // 表示する選択肢配列
    let face : String           // 表示する女の子画像パス
}

struct JSONData : Codable
{
    
}
