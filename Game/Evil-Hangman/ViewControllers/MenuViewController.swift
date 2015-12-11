//
//  MenuViewController.swift
//  Evil-Hangman
//
//  Created by Mees Fröberg on 08/12/15.
//  Copyright © 2015 Mees Fröberg. All rights reserved.
//
// This is the ViewController of the menu screen. In this screen the user can navigate to the other
// screens of the app.

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
    
    /// This function is triggered when the "new game" button is pressed.
    @IBAction func newGame(sender: AnyObject) {
        game.startNewGame()
        self.performSegueWithIdentifier("game", sender: sender)
    }
    
    /// This function is triggered when the "manual" button is pressed.
    @IBAction func manual(sender: AnyObject) {
        self.performSegueWithIdentifier("manual", sender: sender)
    }
    
    /// This function is triggered when the "highscores" button is pressed.
    @IBAction func highscores(sender: AnyObject) {
        self.performSegueWithIdentifier("highscores", sender: sender)
    }
    
    /// This function is triggered when the "settings" button is pressed.
    @IBAction func settings(sender: AnyObject) {
        self.performSegueWithIdentifier("settings", sender: sender)
    }
    
    /// This function is triggered when the "Go Back" button is pressed.
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
