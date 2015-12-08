//
//  HighscoresViewController.swift
//  Evil-Hangman
//
//  Created by Mees Fröberg on 08/12/15.
//  Copyright © 2015 Mees Fröberg. All rights reserved.
//
import UIKit

class HighscoresViewController: UIViewController {
    
    var game:Game!
    var returnSegue:String!
    
    @IBOutlet weak var moneyLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        moneyLabel.text = "$"+String(game.getMoney())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func back(sender: AnyObject) {
        self.performSegueWithIdentifier(returnSegue, sender: sender)
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
}