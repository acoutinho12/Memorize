//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Andre Luis Barbosa Coutinho on 21/02/21.
//

import SwiftUI

@main
struct MemorizeApp: App {
    var game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
