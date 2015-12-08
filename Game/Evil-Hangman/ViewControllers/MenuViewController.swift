//
//  MenuViewController.swift
//  Evil-Hangman
//
//  Created by Mees Fröberg on 08/12/15.
//  Copyright © 2015 Mees Fröberg. All rights reserved.
//
import UIKit

class MenuViewController: UIViewController {
    
    var game:Game!
    
    @IBOutlet weak var moneyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moneyLabel.text = "$"+String(game.getMoney())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func newGame(sender: AnyObject) {
        game.startNewGame()
        self.performSegueWithIdentifier("game", sender: sender)
    }
    
    @IBAction func manual(sender: AnyObject) {
        self.performSegueWithIdentifier("manual", sender: sender)
    }
    
    @IBAction func highscores(sender: AnyObject) {
        self.performSegueWithIdentifier("highscores", sender: sender)
    }
    
    @IBAction func settings(sender: AnyObject) {
        self.performSegueWithIdentifier("settings", sender: sender)
    }
    
    @IBAction func back(sender: AnyObject) {
        if game.wonGame() || game.lostGame() {
	        self.performSegueWithIdentifier("finish", sender: sender)
        } else {
            self.performSegueWithIdentifier("game", sender: sender)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "game" {
            let destination = segue.destinationViewController as! GameViewController
            destination.game = nil
        } else if segue.identifier == "finish" {
            let destination = segue.destinationViewController as! FinishViewController
            destination.game = game
        } else if segue.identifier == "settings" {
            let destination = segue.destinationViewController as! SettingsViewController
            destination.returnSegue = "menu"
            destination.game = game
        } else if segue.identifier == "manual" {
            let destination = segue.destinationViewController as! ManualViewController
            destination.game = game
        } else if segue.identifier == "highscores" {
            let destination = segue.destinationViewController as! HighscoresViewController
            destination.returnSegue = "menu"
            destination.game = game
        }
    }
}