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
    private var highScores:[String:[String]]
    private var currentGameType:String
    private var gameTypeChanged:Bool
	
	// Initialze the Game class.
    init(defaults:NSUserDefaults) {
        gameplay = EvilGameplay()
        guesses = [0,0]
        money = 100
        highScores = ["GoodGameplay": [], "EvilGameplay": []]
        currentGameType = "GoodGameplay"
        gameTypeChanged = false
	}
    
    
    init(word:String, display:[Character], maxWordLength:Int, guesses:[Int], money:Int, highScores:[String:[String]]) {
        gameplay = GoodGameplay(word: word, display: display, maxWordLength: maxWordLength)
        self.guesses = guesses
        self.money = money
        self.highScores = highScores
        currentGameType = "GoodGameplay"
        gameTypeChanged = false
    }
    
    init(possibleWords:String, display:[Character], maxWordLength:Int, guesses:[Int], money:Int, highScores:[String:[String]]) {
        gameplay = GoodGameplay(word: word, display: display, maxWordLength: maxWordLength)
        self.guesses = guesses
        self.money = money
        self.highScores = highScores
        currentGameType = "GoodGameplay"
        gameTypeChanged = false
    }
    
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
        } else {
			gameplay.newGame()
        }
	}
	
	// Handle the given input of the user. Returns true if the input is correct else false
	func handleInput(input:String) -> Bool {
		if gameplay.handleInput(Character(input.lowercaseString)) {
			guesses[0] = guesses[0] + 1
            return true
		}
        guesses[1] = guesses[1] + 1
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
        return display
	}
    
    func addMoney(madeMoney:Int) {
        money = money + madeMoney
    }
    
    func eraseError() {
        guesses[1] = guesses[1] - 1
    }
	
    // Return the number of wrong guesses the user made.
    func getCorrectGuesses() -> Int {
        return guesses[0]
    }
    
	// Return the number of wrong guesses the user made.
	func getWrongGuesses() -> Int {
		return guesses[1]
	}
    
    func getCorrectWord() -> String {
        return gameplay.getCorrectWord()
    }
}