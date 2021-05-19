//
//  Hint.swift
//  bubblePoppers
//
//  Created by Felix Halim on 22/4/21.
//

import Foundation

struct Hint {
    let hintCollection = ["Black Bubble is 10 pts", "Black Bubbles have 5% chance", "A Blue Bubble is 8 pts", "Blue Bubbles have 10% chance", "Green Bubble is 5 pts", "Green Bubbles have 15%", "Pink Bubble is 2 pts", "Pink Bubbles have 30% chance", "A Red Bubble is worth 1 pts", "Black Bubbles have 40%"]
    
    func generateHint() -> String {
        let randomInt = Int.random(in: 1..<hintCollection.count);
        return hintCollection[randomInt];
    }
}
