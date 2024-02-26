//
//  ContentView.swift
//  DrawApp
//
//  Created by 田辺　奨 on 2024/02/05.
//

import SwiftUI
import AVFoundation
import SwiftUIIntrospect
import UIKit
import Combine


let musicData = NSDataAsset(name: "Quiz-Correct_Answer02-1")!.data
let musicData1 = NSDataAsset(name: "Quiz-Wrong_Buzzer02-1")!.data
var musicPlayer:AVAudioPlayer!
var resultTime: NSNumber = 0.000000000000000
let maxCharacterLength = Int(4)
var randomInt = Int.random(in: 1..<3)


struct Level1Content: View {
    
    @State var varnum1 = level1rundomNum()
    @State var varnum2 = level1rundomNum()
    @State var questionNum = 1
    
    
    @State private var answer = ""
    
    @State private var timeInterval: TimeInterval = 0
    
    @State var isActiveSubView = false
    
    private let formatter = TimerFormatter()
    private let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        NavigationStack{
            VStack {
                
                Spacer()
                //------------------
            
                Text(NSNumber(value: timeInterval), formatter: formatter)
                    .font(Font(UIFont.monospacedDigitSystemFont(ofSize: 30, weight: .light)))
                    .onReceive(timer) { _ in
                        timeInterval += 0.01
                    
                    
                    }
                    
                   
                //------------------
                
                
                HStack(){
                    
                    
                   
                    
                    
                    multNum(x: varnum1, y: varnum2)
                        .frame(width: 230, height: 200, alignment:.trailing)
                    
                    
                    Text(answer)
                        .padding()
                        .font(.custom("LatinModernMath-Regular",size: 50))
                        .foregroundColor(.black)
                        .frame(alignment:.leading)
                        
                    Spacer()
                    
                    
                  
                    
                    
                }//Hs
                
                
                Button{
                    
                    if varnum1 * varnum2 == Int(answer){
                        
                        do{
                            musicPlayer = try AVAudioPlayer(data: musicData)
                            musicPlayer.play()
                        }catch{
                            print("音の再生に失敗しました。")
                        }
                        
                        questionNum += 1
                        varnum1 = level1rundomNum()
                        varnum2 = level1rundomNum()
                        answer = ""
                        
                        resultTime = NSNumber(value: timeInterval)
                        
                        
                        
                    }else{
                        do{
                            musicPlayer = try AVAudioPlayer(data: musicData1)
                            musicPlayer.play()
                        }catch{
                            print("音の再生に失敗しました。")
                        }
                    }
                    if questionNum == 11{
                        isActiveSubView = true
                    }
                    
                    
                    
                } label: {
                    Text("解答する")
                }
                .navigationDestination(isPresented: $isActiveSubView) {
                    ShowResult()
                }
                
                
                Spacer()
                //-------------------------------------------------------------------------------------------------
                
                
                
                
                
                TextField("Your Answer", text: $answer)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad) // 追加
                
                    .introspect(.textField, on: .iOS(.v13, .v14, .v15, .v16, .v17)) {
                        textField in
                        textField.becomeFirstResponder()
                    }.onReceive(Just(answer), perform: { _ in
                        if maxCharacterLength < answer.count {
                            answer = String(answer.prefix(maxCharacterLength))
                        }
                    })
                
                
                
                
                
                //---------------------------------------------------------------------------------------------------
                
            }//Vs
        }
    }//body
}//view

struct ShowResult: View {
    private let formatter = TimerFormatter()
    
    var body: some View {
        Text(resultTime, formatter: formatter)
            .font(Font(UIFont.monospacedDigitSystemFont(ofSize: 50, weight: .light)))
        
    }
}

func level1rundomNum() -> Int {
    
    return Int.random(in: 0..<10)
}//rundom

func level2rundomNum() -> Int {
    
    return Int.random(in: 0..<20)
}//rundom

func multNum(x:Int,y:Int) -> some View{
    return Text("\(x)×\(y) =")
        .padding()
        .font(.custom("LatinModernMath-Regular",size: 50))
        .foregroundColor(.black)
   
}

func addNum(x:Int,y:Int) -> some View{
    return Text("\(x)+\(y) =")
        .padding()
        .font(.custom("LatinModernMath-Regular",size: 50))
        .foregroundColor(.black)
}




func mixNum(x:Int,y:Int) -> some View{
    
    
    return HStack{
        if randomInt == 1{
            multNum(x: x, y: y)
        }else{
           addNum(x: x, y: y)
        }
    }
 
}



#Preview {
    Level1Content()
    
}
