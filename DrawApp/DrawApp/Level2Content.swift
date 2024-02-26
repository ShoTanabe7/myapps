import SwiftUI
import AVFoundation
import SwiftUIIntrospect
import UIKit
import Combine


struct Level2Content: View {
    
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
                    
                    
                    mixNum(x: varnum1, y: varnum2)
                        .frame(width: 230, height: 200, alignment:.trailing)
                    
                    Text(answer)
                        .padding()
                        .font(.custom("LatinModernMath-Regular",size: 50))
                        .foregroundColor(.black)
                        .frame(alignment:.leading)
                        
                    Spacer()
                    
                    
                  
                    
                    
                }//Hs
                
                
                Button{
                    
                    if varnum1 * varnum2 == Int(answer) && randomInt == 1{
                        
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
                        randomInt = Int.random(in: 1..<3)
                        
                        resultTime = NSNumber(value: timeInterval)
                        
                        
                        
                    }else if varnum1 + varnum2 == Int(answer) && randomInt == 2{
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
                        randomInt = Int.random(in: 1..<3)
                        
                        resultTime = NSNumber(value: timeInterval)
                    }
                    
                    else{
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

#Preview {
    Level2Content()
    
}
