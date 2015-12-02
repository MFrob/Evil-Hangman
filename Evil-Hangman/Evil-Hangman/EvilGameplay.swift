//
//  EvilGameplay.swift
//  Evil-Hangman
//
//  Created by Mees Fröberg on 02/12/15.
//  Copyright © 2015 Mees Fröberg. All rights reserved.
//

import Foundation

class EvilGameplay : Gameplay {
    private var possibleWords:[String]
    private var wordLength:Int
    
    // Initialize the GoodGameplay class.
    override init() {
        wordLength = 0
        possibleWords = [String]()
        super.init()
    }
    
    // Start a new game.
    override func newGame() {
        pickPossibleWords()
        super.display = [Character](count: wordLength, repeatedValue: "_")
    }
    
    // Handles the input and returns true if the guess was correct and false otherwise.
    override func handleInput(input:Character) -> Bool {
        var displayWords = [String:[String]]()
        var correctDisplay = [Int:[Character]]()
        
        for word in possibleWords {
            var newDisplay = super.display
            var correct = 0
            
            if word.characters.contains(input) {
                var index = 0
                for char in word.characters {
                    if char == input{
                        newDisplay[index] = char
                        correct = correct + 1
                    }
                    index = index + 1
                }
            }
            
            if var value = displayWords[String(newDisplay)] {
                value.append(word)
                displayWords[String(newDisplay)] = value
            } else {
                displayWords[String(newDisplay)] = [word]
                correctDisplay[correct] = newDisplay
            }
        }
        
        let best = Array(correctDisplay.keys).minElement()
        super.display = correctDisplay[best!]!
        possibleWords = displayWords[String(super.display)]!
        if best == 0 {
            return false
        }
        return true
        
    }
    
    // Select a random word from the corpus.s
    func pickPossibleWords() {
        possibleWords = []
        wordLength = Int(arc4random_uniform(UInt32(super.maxWordLength)))
        for word in super.corpus {
            if word.characters.count == wordLength {
                possibleWords.append(word)
            }
        }
    }
}