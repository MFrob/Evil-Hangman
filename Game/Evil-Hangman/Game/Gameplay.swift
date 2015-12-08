//
//  Gameplay.swift
//  Evil-Hangman
//
//  Created by Mees Fröberg on 11/11/15.
//  Copyright © 2015 Mees. All rights reserved.
//
// This class is the representation of general gameplay. Every type of gameplay has to contain the features in this class.

import Foundation

class Gameplay {
	internal var display:[Character]
    internal var maxWordLength:Int
	internal var corpus:[String]
    internal var possibleWords:[String]
	
	init() {
		display = [Character]()
        maxWordLength = 6
		corpus = [String]()
        possibleWords = [String]()
        loadCorpus("words")
	}
    
	/// Initialize the GoodGameplay class with the given possible words and max word length.
    init(possibleWords:[String], maxWordLength:Int) {
        self.maxWordLength = maxWordLength
        self.corpus = [String]()
        self.possibleWords = possibleWords
        display = [Character](count: possibleWords[0].characters.count, repeatedValue: "_")
        loadCorpus("words")
    }
	
    func newGame() {
        preconditionFailure("This function must be overridden")
	}
	
	func handleInput(input:Character) -> Bool {
        preconditionFailure("This function must be overridden")
	}
	
    func changeMaxWordLength(length:Int) {
        maxWordLength = length
    }
    
	/// Load the corpus from the given .plist file.
    private func loadCorpus(filename:String) {
        let path = NSBundle.mainBundle().pathForResource(filename, ofType: "plist")
        corpus = NSArray(contentsOfFile: path!) as! [String]
    }
    
    func getCorrectWord() -> String {
        return possibleWords[0]
    }
	
	func getDisplay() -> [Character] {
		return display
	}
	
	func getPossibleWords() -> [String] {
		return possibleWords
	}
}