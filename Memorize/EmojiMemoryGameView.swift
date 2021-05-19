//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Andre Luis Barbosa Coutinho on 21/02/21.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    let duration: Double = 0.350
    
    var body: some View {
        ZStack{
        Grid(viewModel.cards) { card in
            CardView(card: card).onTapGesture {
                withAnimation(.linear(duration:duration)) {
                    self.viewModel.choose(card: card)
                }
            }
                .padding()
        }.padding()
        .foregroundColor(.orange)
            if viewModel.isEndGame()
            {
                HStack{
                Button(action: { withAnimation(.easeInOut(duration:duration)){
                    self.viewModel.newGame()
                } } , label: {
                    Text("New Game".uppercased()).foregroundColor(Color(UIColor.label))
                })
                }.buttonStyle(FilledButtonStyle(backgroundColor: Color(UIColor.systemGray4)))
            }
        }
    }
}


struct CardView: View {
    var card: MemoryGame<String>.Card
    var body: some View {
        
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation(){
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View{
        if card.isFaceUp || !card.isMatched{
            ZStack{
                if card.isConsumingBonusTime{
                    Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBonusRemaining*360-90), clockWise: true).padding(5).opacity(0.4)
                        .onAppear {
                            self.startBonusTimeAnimation()
                        }
                }
                else{
                    Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-card.bonusRemaining*360-90), clockWise: true).padding(5).opacity(0.4)
                }
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
            }.cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3
    private let fontScalingFactor: CGFloat = 0.75
    
    func fontSize(for size: CGSize) -> CGFloat{
        min(size.width,size.height) * fontScalingFactor
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame();
        game.choose(card: game.cards[0]);
        return EmojiMemoryGameView(viewModel: game)
    }
}
