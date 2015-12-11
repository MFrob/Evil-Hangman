//
//  GameViewController.swift
//  Evil-Hangman
//
//  Created by Mees Fröberg on 19/11/15.
//  Copyright © 2015 Mees Fröberg. All rights reserved.
//
// This is the ViewController of the game screen. In this screen the user is playing
// a hangman game.

import UIKit

class GameViewController: UIViewController {
    
    var game:Game!
    let defaults = NSUserDefaults.standardUserDefaults()
    
    // Label outlets.
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    
    // Image outlets.
    @IBOutlet weak var errorImage1: UIImageView!
    @IBOutlet weak var errorImage2: UIImageView!
    @IBOutlet weak var errorImage3: UIImageView!
    @IBOutlet weak var errorImage4: UIImageView!
    @IBOutlet weak var errorImage5: UIImageView!
    @IBOutlet weak var errorImage6: UIImageView!
    @IBOutlet weak var errorImage7: UIImageView!
    @IBOutlet weak var errorImage8: UIImageView!
    @IBOutlet weak var errorImage9: UIImageView!
    @IBOutlet weak var errorImage10: UIImageView!
    @IBOutlet weak var errorImage11: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if game == nil {
        	initializeGame()
        }
        setLabels()
        showDrawing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /// This function is triggered when the user presses a button on the keyboard. Therefore this function
    /// handles the input of the user.
    @IBAction func inputAction(sender: AnyObject) {
        let button = sender as! UIButton
        if game.handleInput(button.titleLabel!.text!) {
            button.backgroundColor = UIColor.greenColor()
        } else {
            button.backgroundColor = UIColor.redColor()
            showDrawing()
        }
        displayLabel.text = game.getDisplay()
        button.enabled = false
        
        if game.wonGame() || game.lostGame() {
            game.addMoney(game.computeScore()[1])
            self.performSegueWithIdentifier("finish", sender: sender)
        }
    }

	/// This function is triggered when the user presses the menu button.
    @IBAction func menu(sender: AnyObject) {
        self.performSegueWithIdentifier("menu", sender: sender)
    }
    
    /// This function is triggered when the user pressed the erase button.
    @IBAction func eraseAction(sender: AnyObject) {
        game.eraseError()
        showDrawing()
        moneyLabel.text = "$"+String(defaults.integerForKey("money"))
    }
    
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "finish" {
            let destination = segue.destinationViewController as! FinishViewController
            destination.checkHighscore = true
            destination.game = game
        } else if segue.identifier == "menu" {
            let destination = segue.destinationViewController as! MenuViewController
            destination.game = game
        }
	}
    
    /// This function initializes the game. To do this the game property must be 
    /// initialized and the button propperties must be configured.
	private func initializeGame() {
        game = Game(defaults:defaults)
        let buttons = getButtons()
        for action in defaults.arrayForKey("actions") as! [String] {
            if action == "erase" {
                game.eraseError()
            } else {
                if game.handleInput(action) {
                    for button in buttons {
                        if button.titleLabel!.text == action {
                            button.backgroundColor = UIColor.greenColor()
                            button.enabled = false
                        }
                    }
                } else {
                    for button in buttons {
                        if button.titleLabel!.text == action {
                            button.backgroundColor = UIColor.redColor()
                            button.enabled = false
                        }
                    }
                }
            }
        }
        finishedGame(buttons)
    }
    
    /// Displays the hangman drawing correctly. This depends on the number of errors the user made.
    private func showDrawing() {
        let errors = game.getWrongGuesses()
        switch errors {
        case 1:
            errorImage1.hidden = false
            errorImage2.hidden = true
        case 2:
            errorImage1.hidden = true
            errorImage2.hidden = false
            errorImage3.hidden = true
        case 3:
            errorImage2.hidden = true
            errorImage3.hidden = false
            errorImage4.hidden = true
        case 4:
            errorImage3.hidden = true
            errorImage4.hidden = false
            errorImage5.hidden = true
        case 5:
            errorImage4.hidden = true
            errorImage5.hidden = false
            errorImage6.hidden = true
        case 6:
            errorImage5.hidden = true
            errorImage6.hidden = false
            errorImage7.hidden = true
        case 7:
            errorImage6.hidden = true
            errorImage7.hidden = false
            errorImage8.hidden = true
        case 8:
            errorImage7.hidden = true
            errorImage8.hidden = false
            errorImage9.hidden = true
        case 9:
            errorImage8.hidden = true
            errorImage9.hidden = false
            errorImage10.hidden = true
        case 10:
            errorImage9.hidden = true
            errorImage10.hidden = false
            errorImage11.hidden = true
        case 11:
            errorImage10.hidden = true
            errorImage11.hidden = false
        default:
            errorImage1.hidden = true
        }
    }
    
    /// Checks if the game is already won/lost and handles appropriately.
    private func finishedGame(buttons:[UIButton]) {
    	if game.wonGame() || game.lostGame() {
    		game.startNewGame()
            for button in buttons {
                button.backgroundColor = UIColor.lightGrayColor()
                button.enabled = true
            }
    	}
    }
    
    /// Returns an array of all the buttons on the keyboard.
    private func getButtons() -> [UIButton] {
        var buttons:[UIButton] = []
        for everything in self.view.subviews {
            if everything.tag == 1 {
                for keyboard in everything.subviews {
                    if keyboard.tag == 2 {
                        buttons = getButtonsGroup1(keyboard)
                        buttons += getButtonsGroup2(keyboard)
                    }
                }
            }
        }
        return buttons
    }
    
    /// Returns an array of all the buttons in buttonGroup1.
    private func getButtonsGroup1(keyboard:UIView) -> [UIButton]{
        var buttons:[UIButton] = []
        for buttonGroup in keyboard.subviews {
            if buttonGroup.tag == 3 {
                for but in buttonGroup.subviews {
                    if but.tag == 4 {
                        buttons = but.subviews as! [UIButton]
                    } else if but.tag == 5 {
                        buttons += but.subviews as! [UIButton]
                    }
                }
            }
        }
        return buttons
    }
    
    /// Returns an array of all the buttons in buttonGroup2.
    private func getButtonsGroup2(keyboard:UIView) -> [UIButton] {
        var buttons:[UIButton] = []
        for buttonGroup in keyboard.subviews {
            if buttonGroup.tag == 6 {
                for but in buttonGroup.subviews {
                    if but.tag == 7 {
                        buttons = but.subviews as! [UIButton]
                    } else if but.tag == 8 {
                        buttons += but.subviews as! [UIButton]
                    }
                }
            }
        }
        return buttons
    }
    
    /// This function gives all the labels on the screen the correct text. This depends on the game.
    private func setLabels() {
        moneyLabel.text = "$"+String(game.getMoney())
        
        displayLabel.text = game.getDisplay()
        if defaults.stringForKey("currentGameType")! == "GoodGameplay" {
            titleLabel.text = "Good"
        } else {
            titleLabel.text = "Evil"
        }
    }
}
