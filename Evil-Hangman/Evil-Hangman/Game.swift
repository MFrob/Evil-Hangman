//
//  Game.swift
//  Mad Libs
//
//  Created by Mees Fröberg on 11/11/15.
//  Copyright © 2015 Mees. All rights reserved.
//
// This is the main class that is used to play the hangman game.
//

import Foundation

class Game {
	private var gameplay:Gameplay
    private var guesses:[Int]
    private var money:Int
    private var highscores:[String:[String:Int]]
    private var currentGameType:String
    private var gameTypeChanged:Bool
    //private var defaults:NSUserDefaults
	
	// Initialze the Game class.
    init() {
        /*self.defaults = defaults
        if defaults.stringForKey("currentGameType") != nil {
            
            guesses = defaults.arrayForKey("guesses") as! [Int]
            money = defaults.integerForKey("money")
            highscores = defaults.dictionaryForKey("highscores") as! [String:[String:Int]]
            currentGameType = defaults.stringForKey("currentGameType")!
            gameTypeChanged = defaults.boolForKey("gameTypeChanged")
            
            if currentGameType == "GoodGameplay" {
                gameplay = GoodGameplay()
            } else {
                gameplay = EvilGameplay()
            }
        } else {*/
        	gameplay = GoodGameplay()
            guesses = [0,0]
        	money = 100
            highscores = ["GoodGameplay": [String:Int](), "EvilGameplay": [String:Int]()]
        	currentGameType = "GoodGameplay"
        	gameTypeChanged = false
            
            //initializeDefaults()
        //}
	}
    
    /*private func initializeDefaults() {
        defaults.setObject(guesses, forKey: "guesses")
        defaults.setInteger(money, forKey: "money")
        defaults.setObject(highscores, forKey: "highscores")
        defaults.setObject(currentGameType, forKey: "currentGameType")
        defaults.setBool(gameTypeChanged, forKey: "gameTypeChanged")
        defaults.setObject([String](), forKey: "actions")
    }*/
    
	// Start a new game.
	func startNewGame() {
		guesses = [0,0]
        if gameTypeChanged {
            if currentGameType == "GoodGameplay" {
                gameplay = EvilGameplay()
                currentGameType = "EvilGameplay"
            } else {
                gameplay = GoodGameplay()
                currentGameType = "GoodGameplay"
            }
            gameTypeChanged = false
            //defaults.setBool(gameTypeChanged, forKey: "gameTypeChanged")
            //defaults.setObject(currentGameType, forKey: "currentGameType")
        } else {
			gameplay.newGame()
        }
//        defaults.setObject(guesses, forKey: "guesses")
//        defaults.setObject([String](), forKey: "actions")
	}
	
	// Handle the given input of the user. Returns true if the input is correct else false
	func handleInput(input:String) -> Bool {
//        var actions = defaults.arrayForKey("actions") as! [String]
//        actions.append(input)
//        defaults.setObject(actions, forKey: "actions")
		if gameplay.handleInput(Character(input.lowercaseString)) {
			guesses[0] = guesses[0] + 1
            //defaults.setObject(guesses, forKey: "guesses")
            return true
		}
        guesses[1] = guesses[1] + 1
        //defaults.setObject(guesses, forKey: "guesses")
        return false
	}
    
    func wonGame() -> Bool {
        return !getDisplay().containsString("_")
    }
	
	// Check if the user lost the game.
	func lostGame() -> Bool {
		if guesses[1] == 11 {
			return true
		}
		return false
	}
    
    func changeGameplay() {
        if gameTypeChanged {
            gameTypeChanged = false
        } else {
            gameTypeChanged = true
        }
        //defaults.setBool(gameTypeChanged, forKey: "gameTypeChanged")
    }
    
    func addMoney(madeMoney:Int) {
        money = money + madeMoney
        //defaults.setInteger(money, forKey: "money")
    }
    
    func spendMoney(spentMoney:Int) -> Bool {
        if money - spentMoney >= 0 {
        	money = money - spentMoney
        	//defaults.setInteger(money, forKey: "money")
            return true
        }
        return false
    }
    
    func eraseError() {
        guesses[1] = guesses[1] - 1
//        var actions = defaults.arrayForKey("actions") as! [String]
//        actions.append("erase")
//        defaults.setObject(actions, forKey: "actions")
//        defaults.setObject(guesses, forKey: "guesses")
    }
	
    // Return the number of wrong guesses the user made.
    func getCorrectGuesses() -> Int {
        return guesses[0]
    }
    
	// Return the number of wrong guesses the user made.
	func getWrongGuesses() -> Int {
		return guesses[1]
	}
    
    // Return the current display of the game.
    func getDisplay() -> String {
        var display = ""
        var index = 0
        for char in gameplay.getDisplay() {
            if index == gameplay.getDisplay().count-1 {
                display = display + String(char)
            } else {
                display = display + String(char) + " "
            }
            index = index + 1
        }
        return display.uppercaseString
    }
    
    func getCorrectWord() -> String {
        var display = ""
        var index = 0
        for char in gameplay.getCorrectWord().characters {
            if index == gameplay.getCorrectWord().characters.count-1 {
                display = display + String(char)
            } else {
                display = display + String(char) + " "
            }
            index = index + 1
        }
        return display.uppercaseString
    }
}