//
//  GoodGameplay.swift
//  Mad Libs
//
//  Created by Mees Fröberg on 11/11/15.
//  Copyright © 2015 Mees. All rights reserved.
//

import Foundation

class GoodGameplay : Gameplay {
	private var word:String
	
	// Initialize the GoodGameplay class.
	override init() {
        word = String()
        super.init()
	}
	
	// Start a new game.
	override func newGame() {
		pickWord()
		super.display = [Character](count: word.characters.count, repeatedValue: "_")
	}
	
	// Handles the input and returns true if the guess was correct and false otherwise.
	override func handleInput(input:Character) -> Bool {
        if word.characters.contains(input) {
            var index = 0
            for char in word.characters {
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
		let randomIndex = Int(arc4random_uniform(UInt32(super.corpus.count)))
		word = super.corpus[randomIndex].uppercaseString
        print("Picked word:"+word)
	}
}