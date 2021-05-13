//
//  ArrayHelpers.swift
//  Memorize
//
//  Created by Andre Luis Barbosa Coutinho on 13/05/21.
//

import Foundation

extension Array where Element: Identifiable {
    
    func firstIndex(matching: Element) -> Int? {
            for index in 0..<self.count {
                if(self[index].id == matching.id)
                {
                    return index;
                }
            }
            return nil;
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
