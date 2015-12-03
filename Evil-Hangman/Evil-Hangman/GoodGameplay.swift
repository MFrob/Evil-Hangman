//
//  GoodGameplay.swift
//  Evil-Hangman
//
//  Created by Mees Fröberg on 11/11/15.
//  Copyright © 2015 Mees. All rights reserved.
//

import Foundation

class GoodGameplay : Gameplay {
	
	// Initialize the GoodGameplay class.
	override init() {
        super.init()
	}
    
    override init(possibleWords:[String], maxWordLength:Int) {
        super.init(possibleWords: possibleWords, maxWordLength: maxWordLength)
    }
    
	// Start a new game.
	override func newGame() {
		pickWord()
		display = [Character](count: possibleWords[0].characters.count, repeatedValue: "_")
	}
	
	// Handles the input and returns true if the guess was correct and false otherwise.
	override func handleInput(input:Character) -> Bool {
        if possibleWords[0].characters.contains(input) {
            var index = 0
            for char in possibleWords[0].characters {
                if char == input{
                    display[index] = char
                }
                index = index + 1
            }
            return true
        }
        return false
	}
	
	// Select a random word from the corpus.s
	func pickWord() {
		let randomIndex = Int(arc4random_uniform(UInt32(corpus.count-1)))
		possibleWords = [corpus[randomIndex].lowercaseString]
        print("Picked word:"+possibleWords[0])
	}
}