//
//  LeaderboardViewController.swift
//  bubblePoppers
//
//  Created by Felix Halim on 22/4/21.
//

import UIKit

class LeaderboardViewController: UITableViewController {
    
    var playerScores = [Player]();
    let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("leaderboard.plist");

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //load leaderboard
        loadLeaderboard()
    }
    
    //TableView Data Source Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerScores.count;
    }
    
    //Set Cells in the table view
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let player = playerScores[indexPath.row];
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreCell", for: indexPath);
        cell.textLabel?.text = "\(player.name): \(player.score)";
        return cell;
    }
    
    //Load leaderboard from plist file
    func loadLeaderboard() {
        if let data = try? Data(contentsOf: filePath!) {
            //Decode data from the plist file and put it in the array as Player Objects
            let decoder = PropertyListDecoder();
            do {
                playerScores = try decoder.decode([Player].self, from: data)
            } catch {
                print("Error Decoding: \(error)");
            }
        }
    }
    
    //Play Again button that returns to the menu
    @IBAction func PlayAgainButtonPressed(_ sender: UIBarButtonItem) {
        //Perform segues to the main menu to play again
        self.performSegue(withIdentifier: "goToMenu", sender: self);
    }
}
