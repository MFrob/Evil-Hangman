//
//  HighscoresViewController.swift
//  Evil-Hangman
//
//  Created by Mees Fröberg on 08/12/15.
//  Copyright © 2015 Mees Fröberg. All rights reserved.
//
// This is the ViewController of the highscores screen. In this screen a list of all the highscores
// is displayed.

import UIKit

class HighscoresViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var game:Game!
    var returnSegue:String!
    var hNames:[String]!
    var hScores:[String]!
    
    // Outlets.
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var highscoresTableView: UITableView!
    @IBOutlet weak var switchGameType: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moneyLabel.text = "$"+String(game.getMoney())
        
        getHighscores(game.getCurrentGameType())
        setSwitch()
        
        highscoresTableView.delegate = self
        highscoresTableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /// This function is triggered when the user pressed the back button.
    @IBAction func back(sender: AnyObject) {
        self.performSegueWithIdentifier(returnSegue, sender: sender)
    }
    
    /// This function is triggered when the user switched the gameplay type.
    @IBAction func switchGameTypeAction(sender: AnyObject) {
        if switchGameType.selectedSegmentIndex == 0 {
            getHighscores("GoodGameplay")
        } else {
            getHighscores("EvilGameplay")
        }
        highscoresTableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "finish" {
            let destination = segue.destinationViewController as! FinishViewController
            destination.game = game
        } else if segue.identifier == "menu" {
            let destination = segue.destinationViewController as! MenuViewController
            destination.game = game
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hNames.count+1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView == highscoresTableView {
            let cell = highscoresTableView.dequeueReusableCellWithIdentifier("highscore", forIndexPath: indexPath)
            
            let row = indexPath.row
            if row == 0 {
                cell.textLabel?.text = "#.Name"
                cell.detailTextLabel?.text = "Score"
            } else {
                cell.textLabel?.text = String(row)+"."+hNames[row-1]
                cell.detailTextLabel?.text = hScores[row-1]
            }
            
            
            return cell
        }
        return UITableViewCell()
    }
    
    /// Initializes the arrays that are used to display the highscores in the table view, given the gameplay type.
    private func getHighscores(gametype:String) {
        var highscores:[String:[String]]
        if gametype == "GoodGameplay" {
            highscores = game.getGoodHighscores()
        } else {
            highscores = game.getEvilHighscores()
        }
        
        hNames = []
        hScores = []
        
        let scores = highscores.keys.sort(>)
        for score in scores {
            for name in highscores[score]! {
                hNames.append(name)
                hScores.append(score)
            }
        }
    }
    
    /// Initializes the switch.
    private func setSwitch() {
        if game.getCurrentGameType() == "GoodGameplay" {
            switchGameType.selectedSegmentIndex = 0
        } else {
            switchGameType.selectedSegmentIndex = 1
        }
    }
    
}
