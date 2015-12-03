//
//  Gameplay.swift
//  Evil-Hangman
//
//  Created by Mees Fröberg on 11/11/15.
//  Copyright © 2015 Mees. All rights reserved.
//

import Foundation

class Gameplay {
	internal var display:[Character]
    internal var maxWordLength:Int
	internal var corpus:[String]
    internal var possibleWords:[String]
	
	// Initialize the Gameplay class.
	init() {
		display = [Character]()
        maxWordLength = 6
		corpus = ["dit","is","een","test","corpus"]
        possibleWords = [String]()
        newGame()
	}
    
    init(possibleWords:[String], maxWordLength:Int) {
        self.maxWordLength = maxWordLength
        corpus = ["dit","is","een","test","corpus"]
        self.possibleWords = possibleWords
        display = [Character](count: possibleWords[0].characters.count, repeatedValue: "_")
    }
	
	// Start a new game.
    func newGame() {
        preconditionFailure("This function must be overridden")
	}
	
	// Handles the input and returns true if the guess was correct and false otherwise.
	func handleInput(input:Character) -> Bool {
        preconditionFailure("This function must be overridden")
	}
    
    func getCorrectWord() -> String {
        return possibleWords[0]
    }
	
	// Return the display.
	func getDisplay() -> [Character] {
		return display
	}
    
    func getMaxWordLenght() -> Int {
        return maxWordLength
    }
    
    func changeMaxWordLength(length:Int) {
        maxWordLength = length
    }
}