//
//  GameViewController.swift
//  Evil-Hangman
//
//  Created by Mees Fröberg on 19/11/15.
//  Copyright © 2015 Mees Fröberg. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    var game:Game!
    
    // Label outlet.
    @IBOutlet weak var displayLabel: UILabel!
    
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
        game = Game()
        game.startNewGame()
        /*if defaults.valueForKey("Game") == nil {
            game = Game()
            game.startNewGame()
            defaults.setObject(game, forKey: "Game")
            defaults.setValue([[UIButton]](count: 2, repeatedValue: [UIButton]()), forKey: "Buttons")
            defaults.synchronize()
        } else {
            game = defaults.valueForKey("Game") as! Game
        }
        
        let usedButtons = defaults.valueForKey("Buttons") as! [[UIButton]]
        for button in usedButtons[0] {
            button.backgroundColor = UIColor.greenColor()
            button.enabled = false
        }
        
        for button in usedButtons[1] {
            button.backgroundColor = UIColor.redColor()
            button.enabled = false
        }*/
        
        displayLabel.text = game.getDisplay()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func inputAction(sender: AnyObject) {
        let button = sender as! UIButton
        if game.handleInput(button.titleLabel!.text!) {
            button.backgroundColor = UIColor.greenColor()
        } else {
            button.backgroundColor = UIColor.redColor()
            let errors = game.getWrongGuesses()
            if errors == 1 {
                errorImage1.hidden = false
            } else if errors == 2 {
                errorImage1.hidden = true
                errorImage2.hidden = false
            } else if errors == 3 {
                errorImage2.hidden = true
                errorImage3.hidden = false
            } else if errors == 4 {
                errorImage3.hidden = true
                errorImage4.hidden = false
            } else if errors == 5 {
                errorImage4.hidden = true
                errorImage5.hidden = false
            } else if errors == 6 {
                errorImage5.hidden = true
                errorImage6.hidden = false
            } else if errors == 7 {
                errorImage6.hidden = true
                errorImage7.hidden = false
            } else if errors == 8 {
                errorImage7.hidden = true
                errorImage8.hidden = false
            } else if errors == 9 {
                errorImage8.hidden = true
                errorImage9.hidden = false
            } else if errors == 10 {
                errorImage9.hidden = true
                errorImage10.hidden = false
            } else if errors == 11 {
                errorImage10.hidden = true
                errorImage11.hidden = false
            }
        }
        displayLabel.text = game.getDisplay()
        button.enabled = false
    }
}