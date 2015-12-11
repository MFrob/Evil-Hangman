//
//  GoodGameplay.swift
//  Evil-Hangman
//
//  Created by Mees Fröberg on 11/11/15.
//  Copyright © 2015 Mees. All rights reserved.
//
// This class is the representation of the good gameplay type.

import Foundation

class GoodGameplay : Gameplay {
	
	override init() {
        super.init()
        newGame()
	}
    
    override init(maxWordLength:Int) {
        super.init(maxWordLength:maxWordLength)
        newGame()
    }
    
    override init(possibleWords:[String], maxWordLength:Int) {
        super.init(possibleWords: possibleWords, maxWordLength: maxWordLength)
    }
    
	override func newGame() {
		pickWord()
		display = [Character](count: possibleWords[0].characters.count, repeatedValue: "_")
	}
	
	/// Handles the input and returns true if the guess was correct and false otherwise.
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
	
	/// Pick a random word from the corpus.
	private func pickWord() {
		// Create an array of words with a length less then or equal to the max word length.
        var newCorpus = [String]()
        for word in corpus {
            if word.characters.count <= maxWordLength {
                newCorpus.append(word)
            }
        }
		// Select a random word from the new corpus.
        let randomIndex = arc4random() % UInt32(newCorpus.count-1)
		possibleWords = [newCorpus[Int(randomIndex)].uppercaseString]
        print("picked word:"+possibleWords[0])
	}
}