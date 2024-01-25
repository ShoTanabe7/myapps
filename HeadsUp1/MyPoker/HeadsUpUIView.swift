//
//  HeadsUpUIView.swift
//  MyPoker
//
//  Created by 田辺　奨 on 2023/09/02.
//

import SwiftUI

let suits = ["s", "d", "c", "h"]
let values = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "T", "J", "Q", "K"]
var trump: [String] {
    suits.flatMap { suit in
        values.map { value in "\(value)\(suit)" }
    }
}



struct HeadsUpUIView: View {
    
    
    
    //背景画像
    let backgroundImage :some View = Image("background").resizable().ignoresSafeArea(edges: [.vertical])
    
    //ラウンドの管理
    @State var round = Round()
    //プレイヤー呼び出し
    @State var player1 = Player(hand1: Card(), hand2: Card())
    @State var player2 = Player(hand1: Card(), hand2: Card())
    //コミュニティカード呼び出し
    @State var communityCard = CommunityCard(flopCard1: Card(), flopCard2: Card(), flopard3: Card(), turnCard: Card(), riverCard: Card())
    
    
    
    
    
    //body---------------------------------------------------------------
    var body: some View {
        
        ZStack{
            backgroundImage
            
            
            VStack{
                Player2CardImages
                Spacer()
                startButton()
                RestartButton()
                CommunityCardImages
                NextFropButton()
                NextTurnButton()
                NextRiverButton()
                Spacer()
                Player1CardImages
            }
            
            
            
        }
        
        
    }//body---------------------------------------------------------------
    
    //カードの情報
    struct Card {
        
        var isFront: Bool
        var cardSituation: String
        
        init() {
            isFront = false
            cardSituation = "backOfCard"
        }
        
    }
    //プレイヤー情報
    struct Player {
        
        
        var hand1: Card
        var hand2: Card
        
        init(hand1: Card, hand2: Card) {
            
            self.hand1 = hand1
            self.hand2 = hand2
        }
    }
    
    
    
    
    //コミュニティカード
    struct CommunityCard {
        var flopCard1:Card
        var flopCard2:Card
        var flopCard3:Card
        var turnCard:Card
        var riverCard:Card
        
        init(flopCard1: Card, flopCard2: Card, flopard3: Card, turnCard: Card, riverCard: Card) {
            self.flopCard1 = flopCard1
            self.flopCard2 = flopCard2
            self.flopCard3 = flopard3
            self.turnCard = turnCard
            self.riverCard = riverCard
        }
    }
    
    //Player1のカードレイアウト
    private var Player1CardImages: some View {
        HStack {
            if !round.isBeforeStart {
                Button{
                    
                    player1.hand1.isFront.toggle()
                }label: {
                    player1.hand1.isFront ? cardImage(for: player1.hand1.cardSituation) : cardImage(for: "backOfCard")
                }
                
                
                Button{
                    player1.hand2.isFront.toggle()
                }label: {
                    player1.hand2.isFront ? cardImage(for: player1.hand2.cardSituation) : cardImage(for: "backOfCard")
                }
            }
        }
    }
    
    //Player2のカードレイアウト
    private var Player2CardImages: some View {
        
        HStack {
            if !round.isBeforeStart {
                Button{
                    player2.hand1.isFront.toggle()
                }label: {
                    player2.hand1.isFront ? cardImage(for: player2.hand1.cardSituation) : cardImage(for: "backOfCard")
                }
                
                Button{
                    player2.hand2.isFront.toggle()
                }label: {
                    player2.hand2.isFront ? cardImage(for: player2.hand2.cardSituation) : cardImage(for: "backOfCard")
                }
            }
            
        }
    }
    
    
    
    
    //コミュニティカードのレイアウト
    var CommunityCardImages: some View {
        
        HStack {
            
            if !round.isBeforeStart {
                
                if round.isPrefrop{
                    cardImage(for:  "backOfCard")
                    cardImage(for:  "backOfCard")
                    cardImage(for:  "backOfCard")
                    cardImage(for:  "backOfCard")
                    cardImage(for:  "backOfCard")
                }
                
                if round.isFrop {
                    cardImage(for:  communityCard.flopCard1.cardSituation)
                    cardImage(for:  communityCard.flopCard2.cardSituation)
                    cardImage(for:  communityCard.flopCard3.cardSituation)
                    cardImage(for:  "backOfCard")
                    cardImage(for:  "backOfCard")
                }
                
                if round.isTurn {
                    cardImage(for:  communityCard.flopCard1.cardSituation)
                    cardImage(for:  communityCard.flopCard2.cardSituation)
                    cardImage(for:  communityCard.flopCard3.cardSituation)
                    cardImage(for: communityCard.turnCard.cardSituation)
                    cardImage(for:  "backOfCard")
                    
                }
                
                if round.isRiver {
                    cardImage(for:  communityCard.flopCard1.cardSituation)
                    cardImage(for:  communityCard.flopCard2.cardSituation)
                    cardImage(for:  communityCard.flopCard3.cardSituation)
                    cardImage(for: communityCard.turnCard.cardSituation)
                    cardImage(for: communityCard.riverCard.cardSituation)
                }
                
            }
        }
        
        
    }
    
    //ラウンドの把握
    struct Round {
        var isBeforeStart: Bool
        var isPrefrop: Bool
        var isFrop: Bool
        var isTurn: Bool
        var isRiver: Bool
        
        init() {
            self.isBeforeStart = true
            self.isPrefrop = false
            self.isFrop = false
            self.isTurn = false
            self.isRiver = false
        }
        
    }
    
    //Restart
    func RestartButton() -> some View {
        Button{
            
            round.isPrefrop = true
            round.isFrop = false
            round.isTurn = false
            round.isRiver = false
            
            player1.hand1.isFront = false
            player1.hand2.isFront = false
            player2.hand1.isFront = false
            player2.hand2.isFront = false

            dealCards()
            
           
        }label: {
            if !round.isBeforeStart{
                Text("Restart")
            }
        }
        .background(Color.red)
    }
    
    
    
    //スタートボタン
    func startButton() -> some View {
        Button{
            dealCards()
            round.isBeforeStart = false
            round.isPrefrop = true
        }label: {
            if round.isBeforeStart {
                Text("スタート")
            }
        }
        .background(Color.red)
    }
    
    
    func NextFropButton() -> some View {
        Button{
            
            round.isPrefrop = false
            round.isFrop = true
        }label: {
            if round.isPrefrop {
                Text("next")
            }
        }
        .background(Color.red)
    }
    
    func NextTurnButton() -> some View {
        Button{
            
            round.isFrop = false
            round.isTurn = true
        }label: {
            if round.isFrop {
                Text("next")
            }
        }
        .background(Color.red)
    }
    
    func NextRiverButton() -> some View {
        Button{
            
            round.isTurn = false
            round.isRiver = true
        }label: {
            if round.isTurn {
                Text("next")
            }
        }
        .background(Color.red)
    }
    
    
    func dealCards() {
        let randomIndices = Array(0..<52).shuffled().prefix(9)
        
        player1.hand1.cardSituation = trump[randomIndices[0]]
        player1.hand2.cardSituation = trump[randomIndices[1]]
        
        player2.hand1.cardSituation = trump[randomIndices[2]]
        player2.hand2.cardSituation = trump[randomIndices[3]]
        
        communityCard.flopCard1.cardSituation = trump[randomIndices[4]]
        communityCard.flopCard2.cardSituation = trump[randomIndices[5]]
        communityCard.flopCard3.cardSituation = trump[randomIndices[6]]
        
        communityCard.turnCard.cardSituation = trump[randomIndices[7]]
        
        communityCard.riverCard.cardSituation = trump[randomIndices[8]]
        
        
    }
    
    func cardImage(for situation: String) -> some View {
        Image(situation)
            .resizable()
            .frame(width: 70, height: 105)
            
        
    }
    
}//HeadsUpUIView





struct HeadsUpUIView_Previews: PreviewProvider {
    static var previews: some View {
        HeadsUpUIView()
    }
}
