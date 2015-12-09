//
//  FinishViewController.swift
//  Evil-Hangman
//
//  Created by Mees Fröberg on 02/12/15.
//  Copyright © 2015 Mees Fröberg. All rights reserved.
//

import UIKit

class FinishViewController: UIViewController {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    var game:Game!
    var checkHighscore = false
    
    // Label outlets.
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var madeMoneyLabel: UILabel!
    
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
        let score = game.computeScore()
        
        scoreLabel.text = "Score: "+String(score[0])
        madeMoneyLabel.text = "+$"+String(score[1])
        
        if game.wonGame() {
            feedbackLabel.text = "Congratulations!"
        } else {
            feedbackLabel.text = "Try again"
        }
        if defaults.stringForKey("currentGameType")! == "GoodGameplay" {
            titleLabel.text = "Good"
        } else {
            titleLabel.text = "Evil"
        }
        moneyLabel.text = "$"+String(game.getMoney())
        
        showDrawing()
        displayLabel.text = game.getCorrectWord()
        if game.wonGame() && checkHighscore && game.checkHighscore(score[0]) {
            print("New highscore!!")
            var alertController:UIAlertController?
            alertController = UIAlertController(title: "New Highscore!",
                message: "Score: "+String(score[0]),
                preferredStyle: .Alert)
            
            alertController!.addTextFieldWithConfigurationHandler(
                {(textField: UITextField!) in
                    textField.placeholder = "Enter name"
            })
            
            let action = UIAlertAction(title: "Submit",
                style: UIAlertActionStyle.Default,
                handler: {[weak self]
                    (paramAction:UIAlertAction!) in
                    if let textFields = alertController?.textFields{
                        let theTextFields = textFields as [UITextField]
                        let enteredText = theTextFields[0].text
                        self!.displayLabel.text = enteredText
                    }
                })
            
            alertController?.addAction(action)
            self.presentViewController(alertController!,
                animated: true,
                completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func playAgainAction(sender: AnyObject) {
        game.startNewGame()
        self.performSegueWithIdentifier("playAgain", sender: sender)
    }
    
    @IBAction func settings(sender: AnyObject) {
    	self.performSegueWithIdentifier("settings", sender: sender)
    }
    
    @IBAction func highscores(sender: AnyObject) {
        self.performSegueWithIdentifier("highscores", sender: sender)
    }
    
    @IBAction func menu(sender: AnyObject) {
        self.performSegueWithIdentifier("menu", sender: sender)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "playAgain" {
            let destination = segue.destinationViewController as! GameViewController
            destination.game = game
        } else if segue.identifier == "menu" {
            let destination = segue.destinationViewController as! MenuViewController
            destination.game = game
        } else if segue.identifier == "highscores" {
            let destination = segue.destinationViewController as! HighscoresViewController
            destination.returnSegue = "finish"
            destination.game = game
        } else if segue.identifier == "settings" {
            let destination = segue.destinationViewController as! SettingsViewController
            destination.returnSegue = "finish"
            destination.game = game
        }
    }
    
    private func showDrawing() {
        let errors = game.getWrongGuesses()
        switch errors {
        case 1:
            errorImage1.hidden = false
        case 2:
            errorImage2.hidden = false
        case 3:
            errorImage3.hidden = false
        case 4:
            errorImage4.hidden = false
        case 5:
            errorImage5.hidden = false
        case 6:
            errorImage6.hidden = false
        case 7:
            errorImage7.hidden = false
        case 8:
            errorImage8.hidden = false
        case 9:
            errorImage9.hidden = false
        case 10:
            errorImage10.hidden = false
        case 11:
            errorImage11.hidden = false
        default:
            break
        }
    }
}