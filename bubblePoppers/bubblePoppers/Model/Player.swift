//
//  Player.swift
//  bubblePoppers
//
//  Created by Felix Halim on 22/4/21.
//

import Foundation

struct Player: Codable {
    var name: String = "Unknown Player";
    var score: Double = 0;
    var time: Int = 60;
    var maxBubble: Int = 15;
    
    mutating func setName(playerName: String){
        //if name is empty than use default name
        if name.isEmpty || name == ""{
            name = "Unkown Player"
        } else {
            name = playerName;
        }
    }
    
    mutating func setSettings(timeVal: Int, maxBubbleVal: Int){
        time = timeVal;
        maxBubble = maxBubbleVal;
    }
    
    mutating func setScore(finalScore: Double) {
        score = finalScore;
    }
}
