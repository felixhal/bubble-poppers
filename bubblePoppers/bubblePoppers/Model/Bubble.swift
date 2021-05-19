//
//  Bubble.swift
//  bubblePoppers
//
//  Created by Felix Halim on 22/4/21.
//

import UIKit

class Bubble: UIButton {
    var viewWidth = UInt32(UIScreen.main.bounds.width);
    var viewHeight = UInt32(UIScreen.main.bounds.height);
    var points: Double = 0;
    var radius: UInt32 = UInt32(UIScreen.main.bounds.width / 15);
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!;
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        if viewHeight > viewWidth {
            radius = UInt32(UIScreen.main.bounds.width / 15);
        } else {
            radius = UInt32(UIScreen.main.bounds.height / 15);
        }
        
        self.layer.cornerRadius = CGFloat(radius);
        
        //Probability of appearing n/100
        let probability = Int.random(in: 1..<101);
        if probability <= 5{
            self.backgroundColor = .black;
            self.points = 10;
        } else if probability >= 6 && probability <= 15 {
            self.backgroundColor = .blue;
            self.points = 8;
        } else if probability >= 16 && probability <= 30 {
            self.backgroundColor = .green;
            self.points = 5;
        } else if probability >= 31 && probability <= 60 {
            self.backgroundColor = .systemPink;
            self.points = 2;
        } else if probability >= 61 && probability <= 100 {
            self.backgroundColor = .red;
            self.points = 1;
        } else {
            print("Invalid Number");
        }
    }
    
    func checkIntersect(currentBubble: Bubble, bubbles: [Bubble]) -> Bool {
        //for each bubble check if the frame intercept with the current bubble
        for bubble in bubbles {
            if currentBubble.frame.intersects(bubble.frame) {
                return true;
            }
        }
        return false;
    }
}
