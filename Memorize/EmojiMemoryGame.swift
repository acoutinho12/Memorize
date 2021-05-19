//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Andre Luis Barbosa Coutinho on 21/02/21.
//

import Foundation

class EmojiMemoryGame:ObservableObject{
    @Published private var model:MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    private static func createMemoryGame() -> MemoryGame<String> {
        var emojis: Array<String> = []
        for _ in 0...4 {
            emojis.append(String(UnicodeScalar(Int.random(in: 0x1F601...0x1F64F)) ?? "-"))
        }
        return MemoryGame<String>(numberOfPairOfCards: Int.random(in: 2..<6)) { pairIndex in
            return emojis[pairIndex]
        }
    }
       
    func isEndGame() -> Bool{
        return model.isEndGame;
    }
    
    func newGame() -> Void{
        model = EmojiMemoryGame.createMemoryGame();
    }
    // MARK: - Access to Model
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card){
        model.choose(card: card)
    }
}
