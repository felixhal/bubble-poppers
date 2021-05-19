//
//  ViewController.swift
//  bubblePoppers
//
//  Created by Felix Halim on 22/4/21.
//

import UIKit

class MenuViewController: UIViewController {
    
    var newPlayer = Player();
    var timeVal = 60; //Can be modified in settings
    var maxBubbleVal = 15; //Can be modified in settings
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var maxBubbleLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //UI slider to set the time
    @IBAction func timeSlider(_ sender: UISlider) {
        let time = Int(sender.value);
        timeLabel.text = String(time);
        timeVal = time;
    }
    
    //UI slider to set the maximum bubble
    @IBAction func maxBubbleSlider(_ sender: UISlider) {
        let maxBubble = Int(sender.value);
        //visualises the slider value in the label
        maxBubbleLabel.text = String(maxBubble);
        maxBubbleVal = maxBubble;
    }
    
    //Start button pressed to move to count down timer
    @IBAction func startButtonPressed(_ sender: UIButton) {
        //Validate and Set Player Name
        newPlayer.setName(playerName: nameTextField.text!);
        //Set Settings
        newPlayer.setSettings(timeVal: timeVal, maxBubbleVal: maxBubbleVal)
        //Pass newPlayer object with settings and player profile info
        self.performSegue(withIdentifier: "goToCountDown", sender: self)
    }
    
    //Button that directs to the leaderboard
    @IBAction func leaderboardButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToCheckLeaderboard", sender: self)
    }
    
    //Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //If Segue is countdown segue
        if segue.identifier == "goToCountDown" {
            let destinationVC = segue.destination as! CountDownViewController;
            //Pass player object to new segue
            destinationVC.newPlayer = newPlayer;
        }
    }
}

