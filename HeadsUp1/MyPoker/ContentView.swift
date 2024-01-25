//
//  ContentView.swift
//  MyPoker
//
//  Created by 田辺　奨 on 2023/08/30.
//

import SwiftUI

struct ContentView: View {
    var trump: [String] = [
        "As","2s","3s","4s","5s","6s","7s","8s","9s","Ts","Js","Qs","Ks",
        "Ad","2d","3d","4d","5d","6d","7d","8d","9d","Td","Jd","Qd","Kd",
        "Ac","2c","3c","4c","5c","6c","7c","8c","9c","Tc","Jc","Qc","Kc",
        "Ah","2h","3h","4h","5h","6h","7h","8h","9h","Th","Jh","Qh","Kh"
    ]
    
    @State var cardSituation1 = "backOfCard"
    @State var cardSituation2 = "backOfCard"
    
    var body: some View {
        
        VStack{
            Button {
                
                var mutableTrump = trump
                let randomNumber1 = mutableTrump.indices.randomElement()!
                cardSituation1 = mutableTrump[randomNumber1]
                mutableTrump.remove(at: randomNumber1)
                
                let randomNumber2 = mutableTrump.indices.randomElement()!
                cardSituation2 = mutableTrump[randomNumber2]
                
            } label: {
                Image("deck")
                    .resizable()
                    .scaledToFit()
                    .padding()
            }//Button
            
            HStack {
                
                Image(cardSituation1)
                    .resizable()
                    .scaledToFit()
                    .padding()
                
                Image(cardSituation2)
                    .resizable()
                    .scaledToFit()
                    .padding()
                
            }//Hstack
            
            if  cardSituation1 != "backOfCard",
                cardSituation1.prefix(1) == cardSituation2.prefix(1) {
                Text("Pocket")
            }
            
            if  cardSituation1 != "backOfCard",
                cardSituation1.suffix(1) == cardSituation2.suffix(1) {
                Text("Suits")
            }
        }//Vstack
    }//view
}

struct ContentUIView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
