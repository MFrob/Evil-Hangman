//
//  Gameplay.swift
//  Mad Libs
//
//  Created by Mees Fröberg on 11/11/15.
//  Copyright © 2015 Mees. All rights reserved.
//

import Foundation

class Gameplay {
	internal var display:[Character]
    internal var maxWordLength:Int
	internal var corpus:[String]
	
	// Initialize the Gameplay class.
	init() {
		display = [Character]()
        maxWordLength = 6
		corpus = ["dit","is","een","test","corpus"]
	}
    
    init(display:[Character], maxWordLength:Int) {
        self.display = display
        self.maxWordLength = maxWordLength
        corpus = ["dit","is","een","test","corpus"]
    }
	
	// Start a new game.
    func newGame() {
        preconditionFailure("This function must be overridden")
	}
	
	// Handles the input and returns true if the guess was correct and false otherwise.
	func handleInput(input:Character) -> Bool {
        preconditionFailure("This function must be overridden")
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