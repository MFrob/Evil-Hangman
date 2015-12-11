//
//  SettingsViewController.swift
//  Evil-Hangman
//
//  Created by Mees Fröberg on 08/12/15.
//  Copyright © 2015 Mees Fröberg. All rights reserved.
//
// This is the ViewController of the settings screen. In this screen the user can adjust the
// settings of the game.

import UIKit

class SettingsViewController: UIViewController {
    
    var game:Game!
    var returnSegue:String!
    
    // Outlets.
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var gameTypeOutlet: UISegmentedControl!
    @IBOutlet weak var maxWordLengthOutlet: UISlider!
    @IBOutlet weak var maxWordLengthDisplay: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moneyLabel.text = "$"+String(game.getMoney())
        
        initiateSegmentedControl()
        initiateSlider()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /// This function is triggered when the "back" button is pressed
    @IBAction func back(sender: AnyObject) {
        self.performSegueWithIdentifier(returnSegue, sender: sender)
    }
    
    /// This function is triggered when the the max. word length is changed.
    @IBAction func maxWordLengthChanged(sender: AnyObject) {
        maxWordLengthDisplay.text = String(Int(maxWordLengthOutlet.value))
        game.changeMaxWordLength(Int(maxWordLengthOutlet.value))
    }
    
    /// This function is triggered when the gameplay type is changed.
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
    
    /// This function initializes the segment control for the gameplay type.
    private func initiateSegmentedControl() {
        if game.getCurrentGameType() == "GoodGameplay" && game.getGameTypeChanged() {
            gameTypeOutlet.selectedSegmentIndex = 1
        } else if game.getCurrentGameType() == "EvilGameplay" && !game.getGameTypeChanged() {
            gameTypeOutlet.selectedSegmentIndex = 1
        } else {
            gameTypeOutlet.selectedSegmentIndex = 0
        }
    }
    
    /// This function initializes the slider for the max. word length.
    private func initiateSlider() {
        maxWordLengthDisplay.text = String(game.getMaxWordLength())
        maxWordLengthOutlet.value = Float(game.getMaxWordLength())
    }
}
