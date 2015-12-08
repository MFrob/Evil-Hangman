//
//  SettingsViewController.swift
//  Evil-Hangman
//
//  Created by Mees Fröberg on 08/12/15.
//  Copyright © 2015 Mees Fröberg. All rights reserved.
//
import UIKit

class SettingsViewController: UIViewController {
    
    var game:Game!
    var returnSegue:String!
    
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var gameTypeOutlet: UISegmentedControl!
    @IBOutlet weak var maxWordLengthOutlet: UISlider!
    @IBOutlet weak var maxWordLengthDisplay: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moneyLabel.text = "$"+String(game.getMoney())
        if game.getCurrentGameType() == "GoodGameplay" && game.getGameTypeChanged() {
            gameTypeOutlet.selectedSegmentIndex = 1
        } else if game.getCurrentGameType() == "EvilGameplay" && !game.getGameTypeChanged() {
            gameTypeOutlet.selectedSegmentIndex = 1
        } else {
            gameTypeOutlet.selectedSegmentIndex = 0
        }
        maxWordLengthDisplay.text = String(game.getMaxWordLength())
        maxWordLengthOutlet.value = Float(game.getMaxWordLength())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func back(sender: AnyObject) {
        self.performSegueWithIdentifier(returnSegue, sender: sender)
    }
    
    @IBAction func maxWordLengthChanged(sender: AnyObject) {
        maxWordLengthDisplay.text = String(Int(maxWordLengthOutlet.value))
        game.changeMaxWordLength(Int(maxWordLengthOutlet.value))
    }
    
    @IBAction func changedGameType(sender: AnyObject) {
        game.changeGameplay()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "menu" {
            let destination = segue.destinationViewController as! MenuViewController
            destination.game = game
        } else if segue.identifier == "finish" {
            let destination = segue.destinationViewController as! FinishViewController
            destination.game = game
        }
    }
}