//
//  Game.swift
//  Evil-Hangman
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
    private var goodHighscores:[Int:[String]]
    private var evilHighscores:[Int:[String]]
    private var currentGameType:String
    private var gameTypeChanged:Bool
    private var defaults:NSUserDefaults
    private var actions:[String]
    
    init() {
        defaults = NSUserDefaults.standardUserDefaults()
        gameplay = EvilGameplay()
        guesses = [0,0]
        money = 100
        goodHighscores = [Int:[String]]()
        evilHighscores = [Int:[String]]()
        currentGameType = "EvilGameplay"
        gameTypeChanged = false
        actions = [String]()
        updateDefaults()
    }
    
    init(defaults:NSUserDefaults) {
        self.defaults = defaults
		// If defaults is already set.
        if defaults.stringForKey("currentGameType") != nil {
            guesses = defaults.arrayForKey("guesses") as! [Int]
            money = defaults.integerForKey("money")
            goodHighscores = defaults.objectForKey("goodHighscores") as! [Int:[String]]
            evilHighscores = defaults.objectForKey("evilHighscores") as! [Int:[String]]
            currentGameType = defaults.stringForKey("currentGameType")!
            gameTypeChanged = defaults.boolForKey("gameTypeChanged")
            actions = defaults.arrayForKey("actions") as! [String]
            
            let possibleWords = defaults.arrayForKey("possibleWords") as! [String]
            let maxWordLength = defaults.integerForKey("maxWordLength")
            if currentGameType == "GoodGameplay" {
                gameplay = GoodGameplay(possibleWords: possibleWords, maxWordLength: maxWordLength)
            } else {
                gameplay = EvilGameplay(possibleWords: possibleWords, maxWordLength: maxWordLength)
            }
		// If defaults is not yet set.
        } else {
            gameplay = GoodGameplay()
            guesses = [0,0]
            money = 100
            goodHighscores = [Int:[String]]()
            evilHighscores = [Int:[String]]()
            currentGameType = "GoodGameplay"
            gameTypeChanged = false
            actions = [String]()
            
            updateDefaults()
        }
    }
    
    func startNewGame() {
        guesses = [0,0]
        if gameTypeChanged {
            if currentGameType == "GoodGameplay" {
                gameplay = EvilGameplay(maxWordLength:defaults.integerForKey("maxWordLength"))
                currentGameType = "EvilGameplay"
            } else {
                gameplay = GoodGameplay(maxWordLength:defaults.integerForKey("maxWordLength"))
                currentGameType = "GoodGameplay"
            }
            gameTypeChanged = false
        } else {
            gameplay.newGame()
        }
        actions = [String]()
        updateDefaults()
    }
    
    // Handle the given input of the user. Returns true if the input is correct else false
    func handleInput(input:String) -> Bool {
        actions.append(input)
        if gameplay.handleInput(Character(input.uppercaseString)) {
            guesses[0] = guesses[0] + 1
            updateDefaults()
            return true
        }
        guesses[1] = guesses[1] + 1
        updateDefaults()
        return false
    }
    
    func wonGame() -> Bool {
        return !getDisplay().containsString("_")
    }
    
    func lostGame() -> Bool {
        if guesses[1] == 11 {
            return true
        }
        return false
    }
    
    func computeScore() -> [Int] {
        var score:Int
        var madeMoney:Int
        if wonGame() {
            let wordLen = getCorrectWord().characters.count
            let correct = getCorrectGuesses()
            let wrong = getWrongGuesses()
        	score = Int(300 + 15*wordLen + 5*correct - wrong*wrong)
        	madeMoney = Int(score/3)
        } else {
            score = 0
            madeMoney = 0
        }
        return [score,madeMoney]
    }
    
	/// Check if the given score is a highscore.
    func checkHighscore(score:Int) -> Bool {
        var highscores:[Int:[String]]
        if currentGameType == "goodGameplay" {
            highscores = goodHighscores
        } else {
            highscores = evilHighscores
        }
        
        // Return true if the score is a highscore
        var number = 0
        for highscore in highscores.keys {
            if score >= highscore {
                return true
            }
            number = number + highscores[highscore]!.count
        }
        
        if number < 10 {
            return true
        }
        
        return false
    }
    /////////////// TODO: COMMENTS AND CHECK IF WORKING!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	/// Add the given highscore to the highscores.
    func addHighscore(score:Int, name:String) {
        var highscores:[Int:[String]]
        if currentGameType == "goodGameplay" {
            highscores = goodHighscores
        } else {
            highscores = evilHighscores
        }
        
        highscores = addScore(score, name: name, hscores: highscores)
        highscores = removeLowestHighscore(highscores)
        // Remove lowest/oldest highscore.
        
        defaults.setObject(goodHighscores, forKey: "goodHighscores")
        defaults.setObject(evilHighscores, forKey: "evilHighscores")
    }
    
    private func addScore(score:Int, name:String, hscores:[Int:[String]]) -> [Int:[String]] {
        var highscores = hscores
        if highscores[score] == nil {
            highscores.updateValue([name], forKey: score)
        } else {
            var value = highscores[score]!
            value.insert(name, atIndex: 0)
            highscores.updateValue(value, forKey: score)
        }
        return highscores
    }
    
    private func removeLowestHighscore(hscores:[Int:[String]]) -> [Int:[String]] {
        var highscores = hscores
        let scores = highscores.keys.sort(>)
        var value = highscores[scores[scores.count-1]]!
        if value.count == 1 {
            highscores.removeValueForKey(scores[scores.count-1])
        } else {
            value.removeAtIndex(value.count-1)
            highscores.updateValue(value, forKey: scores[scores.count-1])
        }
		return highscores
    }
    
    func changeGameplay() {
        if gameTypeChanged {
            gameTypeChanged = false
        } else {
            gameTypeChanged = true
        }
        defaults.setBool(gameTypeChanged, forKey: "gameTypeChanged")
    }
    
    func changeMaxWordLength(newValue:Int) {
        gameplay.maxWordLength = newValue
        defaults.setInteger(gameplay.maxWordLength, forKey: "maxWordLength")
    }
    
    func addMoney(madeMoney:Int) {
        money = money + madeMoney
        defaults.setInteger(money, forKey: "money")
    }
    
    private func spendMoney(spentMoney:Int) -> Bool {
        if money - spentMoney >= 0 {
            money = money - spentMoney
            defaults.setInteger(money, forKey: "money")
            return true
        }
        return false
    }
    
    func eraseError() -> Bool {
        if getWrongGuesses() > 0 && spendMoney(100) {
            guesses[1] = guesses[1] - 1
            actions.append("erase")
            updateDefaults()
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
        return display.uppercaseString
    }
    
	/// Returns the display of gameplay as a String.
    func getCorrectWord() -> String {
        var display = ""
        var index = 0
        for char in gameplay.getCorrectWord().characters {
            if index == gameplay.getCorrectWord().characters.count-1 {
                display = display + String(char)
            } else {
                display = display + String(char) + " "
            }
            index = index + 1
        }
        return display.uppercaseString
    }
    
    func getCorrectGuesses() -> Int {
        return guesses[0]
    }
    
    func getWrongGuesses() -> Int {
        return guesses[1]
    }
    
    func getMoney() -> Int {
        return money
    }
    
    func getMaxWordLength() -> Int {
        return gameplay.maxWordLength
    }
    
    func getCurrentGameType() -> String {
        return currentGameType
    }
    
    func getGameTypeChanged() -> Bool {
        return gameTypeChanged
    }
    
    func getGoodHighscores() -> [Int:[String]] {
        return goodHighscores
    }
    
    func getEvilHighscores() -> [Int:[String]] {
        return evilHighscores
    }
    
    private func updateDefaults() {
        defaults.setObject(guesses, forKey: "guesses")
        defaults.setInteger(money, forKey: "money")
        defaults.setObject(goodHighscores, forKey: "goodHighscores")
        defaults.setObject(evilHighscores, forKey: "evilHighscores")
        defaults.setObject(currentGameType, forKey: "currentGameType")
        defaults.setBool(gameTypeChanged, forKey: "gameTypeChanged")
        defaults.setObject(gameplay.possibleWords, forKey: "possibleWords")
        defaults.setInteger(gameplay.maxWordLength, forKey: "maxWordLength")
        defaults.setObject([String](), forKey: "actions")
    }
    
    private func printContentDefaults() {
        print("guesses: "+String(defaults.arrayForKey("guesses") as! [Int]))
        print("money: "+String(defaults.integerForKey("money")))
        print("goodHighscores: "+String(defaults.objectForKey("goodHighscores") as! [Int:[String]]))
        print("evilHighscores: "+String(defaults.objectForKey("evilHighscores") as! [Int:[String]]))
        print("currentGameType: "+defaults.stringForKey("currentGameType")!)
        print("gameTypeChanged: "+String(defaults.boolForKey("gameTypeChanged")))
		print("possibleWords: "+String(defaults.arrayForKey("possibleWords") as! [String]))
		print("maxWordLength: "+String(defaults.integerForKey("maxWordLength")))
		print("actions: "+String(defaults.arrayForKey("actions") as! [String]))
    }
}