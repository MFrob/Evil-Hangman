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
        moneyLabel.text = "$"+String(defaults.integerForKey("money"))
        
        showDrawing()
        
        displayLabel.text = game.getCorrectWord()
        game.startNewGame()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func playAgainAction(sender: AnyObject) {
        self.performSegueWithIdentifier("playAgain", sender: sender)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "playAgain" {
            let destination = segue.destinationViewController as! GameViewController
            destination.game = game
        }
    }
    
    private func showDrawing() {
        let errors = game.getWrongGuesses()
        if errors == 1 {
            errorImage1.hidden = false
        } else if errors == 2 {
            errorImage2.hidden = false
        } else if errors == 3 {
            errorImage3.hidden = false
        } else if errors == 4 {
            errorImage4.hidden = false
        } else if errors == 5 {
            errorImage5.hidden = false
        } else if errors == 6 {
            errorImage6.hidden = false
        } else if errors == 7 {
            errorImage7.hidden = false
        } else if errors == 8 {
            errorImage8.hidden = false
        } else if errors == 9 {
            errorImage9.hidden = false
        } else if errors == 10 {
            errorImage10.hidden = false
        } else if errors == 11 {
            errorImage11.hidden = false
        }
    }
}