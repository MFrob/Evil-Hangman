//
//  EvilGameplay.swift
//  Evil-Hangman
//
//  Created by Mees Fröberg on 02/12/15.
//  Copyright © 2015 Mees Fröberg. All rights reserved.
//
// This class is the representation of the evil gameplay type.

import Foundation

class EvilGameplay : Gameplay {
	// This is a dictionary with a display as key and an array of words that match the display.
	private var displayWords:[String:[String]]
	
	// This is a dictionary that has the number of correctly guessed characters as key and the corresponding display as value.
	private var correctDisplay:[Int:[Character]]
	
    override init() {
        displayWords = [String:[String]]()
        correctDisplay = [Int:[Character]]()
        super.init()
		newGame()
    }
    
    override init(maxWordLength:Int) {
        displayWords = [String:[String]]()
        correctDisplay = [Int:[Character]]()
        super.init(maxWordLength:maxWordLength)
        newGame()
    }
    
    override init(possibleWords:[String], maxWordLength:Int) {
        displayWords = [String:[String]]()
        correctDisplay = [Int:[Character]]()
        super.init(possibleWords: possibleWords, maxWordLength: maxWordLength)
    }
    
    override func newGame() {
        let wordLength = pickPossibleWords()
        display = [Character](count: wordLength, repeatedValue: "_")
    }
    
    // Handles the input and returns true if the guess was correct and false otherwise.
    override func handleInput(input:Character) -> Bool {
        displayWords = [String:[String]]()
        correctDisplay = [Int:[Character]]()
        for word in possibleWords {
            let newDisplay = getCorrespondingDisplay(word, input:input)
            let correctGuesses = getCorrectGuesses(newDisplay)
            if var value = displayWords[String(newDisplay)] {
                value.append(word)
                displayWords[String(newDisplay)] = value
            } else {
                displayWords[String(newDisplay)] = [word]
                correctDisplay[correctGuesses] = newDisplay
            }
        }
        
		return makeOptimalDecision()
    }
	
	/// Returns the new display of the given word after the given input.
	private func getCorrespondingDisplay(word:String, input:Character) -> [Character] {
		var newDisplay = display
		if word.characters.contains(input) {
			var index = 0
			for char in word.characters {
				if char == input{
					newDisplay[index] = char
				}
				index = index + 1
			}
		}
        return newDisplay
	}
	
	/// Returns the amount of correctly guessed characters.
	private func getCorrectGuesses(newDisplay:[Character]) -> Int {
		var correctGuesses = 0
		var index = 0
		for char in newDisplay {
			if char != display[index] {
				correctGuesses = correctGuesses + 1
			}
			index = index + 1
		}
		
		return correctGuesses
	}
	
	/// Selects the array of possible words with the least correct guesses. If this amount is 0 return false else return true.
	private func makeOptimalDecision() -> Bool{
		let best = Array(correctDisplay.keys).minElement()
        display = correctDisplay[best!]!
        possibleWords = displayWords[String(display)]!
		if best == 0 {
            return false
        }
        return true
	}
    
    /// Select a random word from the corpus.
    private func pickPossibleWords() -> Int {
        possibleWords = []
        let wordLength = Int(arc4random_uniform(UInt32(maxWordLength)))
        for word in corpus {
            if word.characters.count == wordLength {
                possibleWords.append(word)
            }
        }
        return wordLength
    }
}