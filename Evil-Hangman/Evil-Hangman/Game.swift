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
	
	// Initialze the Game class.
	init() {
		gameplay = GoodGameplay()
		guesses = [0,0]
	}
	
	// Start a new game.
	func startNewGame() {
		guesses = [0,0]
		gameplay.newGame()
	}
	
	// Handle the given input of the user. Returns true if the input is correct else false
	func handleInput(input:String) -> Bool {
		if gameplay.handleInput(Character(input)) {
			guesses[0] = guesses[0] + 1
            return true
		}
        guesses[1] = guesses[1] + 1
        return false
	}
	
	// Check if the user lost the game.
	func lostGame() -> Bool {
		if guesses[1] == 11 {
			return true
		}
		return false
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
	
	// Return the number of wrong guesses the user made.
	func getWrongGuesses() -> Int {
		return guesses[1]
	}
    
    // Return the number of wrong guesses the user made.
    func getCorrectGuesses() -> Int {
        return guesses[0]
    }
}