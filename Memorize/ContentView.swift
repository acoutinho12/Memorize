//
//  ContentView.swift
//  Memorize
//
//  Created by Andre Luis Barbosa Coutinho on 21/02/21.
//

import SwiftUI

struct ContentView: View {
    var viewModel: EmojiMemoryGame
    
    var body: some View {
        HStack(){
            ForEach(viewModel.cards) { card in
                CardView(card: card).onTapGesture {  viewModel.choose(card: card) }
            }
        }.foregroundColor(.orange)
        .padding()
        .font(viewModel.cards.count >= 5 ? Font.title3 : Font.largeTitle)
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    var body: some View {
        ZStack{
            if card.isFaceUp {
            RoundedRectangle(cornerRadius: 10).fill(Color.white)
            RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3)
            Text(card.content)
            }
            else{
                RoundedRectangle(cornerRadius: 10.0).fill()
            }
        }.aspectRatio(2/3,contentMode: .fit)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiMemoryGame())
    }
}
