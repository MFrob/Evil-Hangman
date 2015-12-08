//
//  HighscoresViewController.swift
//  Evil-Hangman
//
//  Created by Mees Fröberg on 08/12/15.
//  Copyright © 2015 Mees Fröberg. All rights reserved.
//
import UIKit

class HighscoresViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var game:Game!
    var returnSegue:String!
    
    @IBOutlet weak var moneyLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        moneyLabel.text = "$"+String(game.getMoney())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func back(sender: AnyObject) {
        self.performSegueWithIdentifier(returnSegue, sender: sender)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "finish" {
            let destination = segue.destinationViewController as! FinishViewController
            destination.game = game
        } else if segue.identifier == "menu" {
            let destination = segue.destinationViewController as! MenuViewController
            destination.game = game
        }
    }
    
    // Delegate methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView == listsOutlet {
            let cell = listsOutlet.dequeueReusableCellWithIdentifier("TextCell", forIndexPath: indexPath)
            
            let row = indexPath.row
            let listsData = defaults.arrayForKey("listData") as! [String]
            cell.textLabel?.text = listsData[row]
            
            return cell
        }
        return UITableViewCell()
    }
    
}