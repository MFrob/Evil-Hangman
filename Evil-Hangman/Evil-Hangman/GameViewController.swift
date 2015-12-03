//
//  GameViewController.swift
//  Evil-Hangman
//
//  Created by Mees Fröberg on 19/11/15.
//  Copyright © 2015 Mees Fröberg. All rights reserved.
//

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
    
    // Button outlets.
//    @IBOutlet weak var a: UIButton!
//    @IBOutlet weak var b: UIButton!
//    @IBOutlet weak var c: UIButton!
//    @IBOutlet weak var d: UIButton!
//    @IBOutlet weak var e: UIButton!
//    @IBOutlet weak var f: UIButton!
//    @IBOutlet weak var g: UIButton!
//    @IBOutlet weak var h: UIButton!
//    @IBOutlet weak var i: UIButton!
//    @IBOutlet weak var j: UIButton!
//    @IBOutlet weak var k: UIButton!
//    @IBOutlet weak var l: UIButton!
//    @IBOutlet weak var m: UIButton!
//    @IBOutlet weak var n: UIButton!
//    @IBOutlet weak var o: UIButton!
//    @IBOutlet weak var p: UIButton!
//    @IBOutlet weak var q: UIButton!
//    @IBOutlet weak var r: UIButton!
//    @IBOutlet weak var s: UIButton!
//    @IBOutlet weak var t: UIButton!
//    @IBOutlet weak var u: UIButton!
//    @IBOutlet weak var v: UIButton!
//    @IBOutlet weak var w: UIButton!
//    @IBOutlet weak var x: UIButton!
//    @IBOutlet weak var y: UIButton!
//    @IBOutlet weak var z: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if game == nil {
        	initializeGame()
        }
        drawDrawing()
        displayLabel.text = game.getDisplay()
        if defaults.stringForKey("currentGameType")! == "GoodGameplay" {
            titleLabel.text = "Good"
        } else {
            titleLabel.text = "Evil"
        }
        moneyLabel.text = "$"+String(defaults.integerForKey("money"))
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
            drawDrawing()
        }
        displayLabel.text = game.getDisplay()
        button.enabled = false
        if game.wonGame() || game.lostGame() {
            self.performSegueWithIdentifier("finishedGame", sender: sender)
        }
    }

    @IBAction func eraseAction(sender: AnyObject) {
        game.eraseError()
        drawDrawing()
        moneyLabel.text = "$"+String(defaults.integerForKey("money"))
    }
    
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "finishedGame" {
            let destination = segue.destinationViewController as! FinishViewController
            destination.game = game
        }
	}
    
	private func initializeGame() {
        game = Game(defaults:defaults)
        //let buttons = [a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z]
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
    }
    
    private func drawDrawing() {
        let errors = game.getWrongGuesses()
        if errors == 0 {
            errorImage1.hidden = true
    	} else if errors == 1 {
            errorImage1.hidden = false
            errorImage2.hidden = true
        } else if errors == 2 {
            errorImage1.hidden = true
            errorImage2.hidden = false
            errorImage3.hidden = true
        } else if errors == 3 {
            errorImage2.hidden = true
            errorImage3.hidden = false
            errorImage4.hidden = true
        } else if errors == 4 {
            errorImage3.hidden = true
            errorImage4.hidden = false
            errorImage5.hidden = true
        } else if errors == 5 {
            errorImage4.hidden = true
            errorImage5.hidden = false
            errorImage6.hidden = true
        } else if errors == 6 {
            errorImage5.hidden = true
            errorImage6.hidden = false
            errorImage7.hidden = true
        } else if errors == 7 {
            errorImage6.hidden = true
            errorImage7.hidden = false
            errorImage8.hidden = true
        } else if errors == 8 {
            errorImage7.hidden = true
            errorImage8.hidden = false
            errorImage9.hidden = true
        } else if errors == 9 {
            errorImage8.hidden = true
            errorImage9.hidden = false
            errorImage10.hidden = true
        } else if errors == 10 {
            errorImage9.hidden = true
            errorImage10.hidden = false
            errorImage11.hidden = true
        } else if errors == 11 {
            errorImage10.hidden = true
            errorImage11.hidden = false
        }
    }
    
    private func getButtons() -> [UIButton] {
        var buttons:[UIButton] = []
        for everything in self.view.subviews {
            if everything.tag == 1 {
                for keyboard in everything.subviews {
                    if keyboard.tag == 2 {
                        for buttonGroup in keyboard.subviews {
                            if buttonGroup.tag == 3 {
                                for but in buttonGroup.subviews {
                                    if but.tag == 4 {
                                        buttons = but.subviews as! [UIButton]
                                    } else if but.tag == 5 {
                                        buttons += but.subviews as! [UIButton]
                                    }
                                }
                            } else if buttonGroup.tag == 6 {
                                for but in buttonGroup.subviews {
                                    if but.tag == 7 {
                                        buttons += but.subviews as! [UIButton]
                                    } else if but.tag == 8 {
                                        buttons += but.subviews as! [UIButton]
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        return buttons
    }
}