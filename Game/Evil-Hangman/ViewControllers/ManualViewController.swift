//
//  ManualViewController.swift
//  Evil-Hangman
//
//  Created by Mees Fröberg on 08/12/15.
//  Copyright © 2015 Mees Fröberg. All rights reserved.
//
// This is the ViewController of the manual screen. In this screen the manual of the game is
// displayed.

import UIKit

class ManualViewController: UIViewController {
    
    var game:Game!
    
    @IBOutlet weak var moneyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moneyLabel.text = "$"+String(game.getMoney())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /// This function is triggered when the back button is pressed.
    @IBAction func back(sender: AnyObject) {
        self.performSegueWithIdentifier("menu", sender: sender)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "menu" {
            let destination = segue.destinationViewController as! MenuViewController
            destination.game = game
        }
    }
}
