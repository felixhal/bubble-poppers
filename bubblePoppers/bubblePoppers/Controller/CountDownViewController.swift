//
//  CountDownViewController.swift
//  bubblePoppers
//
//  Created by Felix Halim on 22/4/21.
//

import UIKit

class CountDownViewController: UIViewController {
    
    var newPlayer: Player?;
    var countDownTime = 5;
    var hint = Hint();
    var timer = Timer();

    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var hintContentLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        //Load greetings with player name
        greetingLabel.text = "Hey, \(newPlayer?.name ?? "Unknown")"
        //Countdown label is set to start from 5
        counterLabel.text = String(countDownTime);
        //Starts timer and selects update timer
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true);
        //Load random hint
        hintContentLabel.text = hint.generateHint();
    }
    
    //updates the counterLabel every 1 second so, it will count down
    @objc func updateTimer() {
        if countDownTime != -1 {
            counterLabel.text = String(countDownTime);
            countDownTime -= 1;
        } else {
            //Once done perform segues
            self.performSegue(withIdentifier: "goToGameArena", sender: self)
            timer.invalidate();
        }
    }
    
    //Pass newPlayer object to the gameArenaViewControlle
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //If Segue is countdown segue
        if segue.identifier == "goToGameArena" {
            let destinationVC = segue.destination as! GameArenaViewController;
            //Pass player object to new segue
            destinationVC.newPlayer = newPlayer;
        }
    }

}
