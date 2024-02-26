//
//  ContentView.swift
//  Myquiz
//
//  Created by 田辺　奨 on 2023/10/30.
//

import SwiftUI
import Vision


struct ContentView: View {
    var body: some View {
        VStack {
            // 「カメラを起動する」ボタン
            Button {
                // ボタンをタップしたときのアクション
                // カメラが利用可能かチェック
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    print("カメラは利用できます")

                } else {
                    print("カメラは利用できません")
                }
            } label: {
                // テキスト表示
                Text("カメラを起動する")
                // 横幅いっぱい
                    .frame(maxWidth: .infinity)
                // 高さ50ポイントを指定
                    .frame(height: 50)
                // 文字列をセンタリング指定
                    .multilineTextAlignment(.center)
                // 背景を青色に指定
                    .background(Color.blue)
                // 文字色を白色に指定
                    .foregroundColor(Color.white)
            } // 「カメラを起動する」ボタンここまで
            // 上下左右に余白を追加
            .padding()
            
        }
        
    }
}



#Preview {
    ContentView()
}
