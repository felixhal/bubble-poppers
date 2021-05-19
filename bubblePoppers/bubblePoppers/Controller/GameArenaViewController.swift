//
//  GameArenaViewController.swift
//  bubblePoppers
//
//  Created by Felix Halim on 22/4/21.
//

import UIKit
import AVFoundation

class GameArenaViewController: UIViewController {
    
    var viewWidth = UInt32(UIScreen.main.bounds.width);
    var viewHeight = UInt32(UIScreen.main.bounds.height);
    
    var playerScores = [Player]();
    var newPlayer: Player?;
    var timer = Timer();
    var bubble = Bubble();
    var bubbles = [Bubble]()
    var countDownTime = 60;
    var maxBubble = 15;
    var score: Double = 0.0;
    var prevBubblePoint: Double = 0.0;
    let sameBubleMutiplier = 1.5;
    let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("leaderboard.plist");
    
    
    @IBOutlet weak var timeLeftLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Apply User Settings
        countDownTime = newPlayer?.time ?? 60;
        maxBubble = newPlayer?.maxBubble ?? 15;
                
        //Get and Display Highscore from Leaderboard
        getLeaderboard();
        highScoreLabel.text = String(getHighest());
        
        //Timer to update time, remove bubble and generate new bubble every second
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
            timer in
            self.updateTimer();
            self.removeBubble();
            self.genBubbles();
        }
        
    }
    
    //Update Countdown timer
    @objc func updateTimer() {
        if countDownTime != 0 {
            timeLeftLabel.text = String(countDownTime);
            countDownTime -= 1;
        } else {
            timer.invalidate();
            newPlayer?.setScore(finalScore: score);
            saveScore();
            self.performSegue(withIdentifier: "goToLeaderboard", sender: self)
        }
    }
    
    //Generate Bubbles
    @objc func genBubbles() {
        var xCons = UInt32(8);
        var yCons = UInt32(160);
        var positionConstX = UInt32(20);
        var positionConstY = UInt32(160);
        var temp: UInt32;
        //Adjust if the screen orientation is landscape
        if viewHeight < viewWidth {
            temp = xCons;
            xCons = yCons;
            yCons = temp;
            temp = positionConstX;
            positionConstX = positionConstY
            positionConstY = positionConstX;
        }

        //random number of bubbles to be generated (sums must be less than max bubbles)
        let numOfBubbles = Int.random(in: 1..<(maxBubble - bubbles.count));
        var i = 0;
        while i < numOfBubbles {
            bubble = Bubble();
            //Create circle in random x, y position but, within boundaries view length and width
            bubble.frame = CGRect(x: CGFloat(xCons + arc4random_uniform(viewWidth - 2 * bubble.radius - positionConstX)), y: CGFloat(yCons + arc4random_uniform(viewHeight - 2 * bubble.radius - positionConstY)), width: CGFloat(2 * bubble.radius), height: CGFloat(2 * bubble.radius))
            //Create bubble subview only if it doesn't intercept other bubble
            if !bubble.checkIntersect(currentBubble: bubble, bubbles: bubbles) {
                bubble.addTarget(self, action: #selector(popBubble), for: UIControl.Event.touchUpInside)
                view.addSubview(bubble)
                i += 1
                //Add bubble into array
                bubbles += [bubble]
            }
        }
    }
    
    //IBAction for tapping bubbles
    @IBAction func popBubble(_ sender: Bubble) {
        //Remove from superview
        sender.removeFromSuperview()
        //Check if previous bubble is same color
        if prevBubblePoint == sender.points {
            //Multiply 1.5
            score += (sender.points * sameBubleMutiplier)
        } else {
            //add points to existing score
            score += sender.points;
        }
        //Update score label and previous bubble
        scoreLabel.text = "\(String(score))"
        prevBubblePoint = sender.points;
    }
    
    //Remove Bubbles
    func removeBubble() {
        var i = 0;
        //Limit the number to be removed (Do not remove all bubbles)
        while i < bubbles.count {
            //20% chance of a bubble getting randomly removed
            if Int.random(in: 1...100) < 20 {
                bubbles[i].removeFromSuperview();
                bubbles.remove(at: i);
                i += 1;
            }
        }
    }
    
    //get current leader board and populate playerScore array
    func getLeaderboard() {
        if let data = try? Data(contentsOf: filePath!) {
            let decoder = PropertyListDecoder();
            do {
                playerScores = try decoder.decode([Player].self, from: data)
            } catch {
                print("Error Decoding: \(error)");
            }
        }
    }
    
    //Get the highest score
    func getHighest() -> Double {
        var highScore = 0.0;
        //For each player in playerScore compare there scores
        for player in playerScores {
            //change the higest score only if
            if player.score > highScore {
                highScore = player.score;
            }
        }
        return highScore;
    }
    
    //Save to score board to leaderboard.plstt file
    func saveScore() {
        //append the newPlayer score to the array
        playerScores.append(newPlayer!);
        //Encode the updated playerScores to the .plist file
        let encoder = PropertyListEncoder();
        do {
            let data = try encoder.encode(playerScores);
            try data.write(to: filePath!);
        } catch {
            print("Error Encoding Data \(error)")
        }
    }
}
