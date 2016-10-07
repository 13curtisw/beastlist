//
//  BeastedViewController.swift
//  BeastList
//
//  Created by Curtis Wang on 9/23/16.
//  Copyright © 2016 Curtis Wang. All rights reserved.
//

import UIKit
import CoreData

class BeastedViewController: UITableViewController {
    
    var beasts = [Beasted]()
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Beasted"
        fetchAllBeasted()
    }
    
    override func viewDidAppear(animated: Bool) {
        fetchAllBeasted()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beasts.count
    }
    
    func fetchAllBeasted() {
        beasts = []
        let beastRequest = NSFetchRequest(entityName: "Beasted")
        do {
            // get the results by executing the fetch request we made earlier
            let results = try managedObjectContext.executeFetchRequest(beastRequest)
            // downcast the results as an array of Beast objects
            let resultsArr = results as? [Beasted]
            // print the details of each beast
            for beast in resultsArr! {
                beasts.append(beast)
            }
        } catch {
            // print the error if it is caught (Swift automatically saves the error in "error")
            print("\(error)")
        }
        
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        cell.textLabel!.text = beasts[indexPath.row].name
        
        let dateformatter = NSDateFormatter()
        dateformatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateformatter.timeStyle = NSDateFormatterStyle.ShortStyle
        let date = dateformatter.stringFromDate(beasts[indexPath.row].date!)
        cell.detailTextLabel?.text = date

        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        managedObjectContext.deleteObject(beasts[indexPath.row])
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
                print("Success")
                fetchAllBeasted()
            } catch {
                print("\(error)")
            }
        }
        tableView.reloadData()
    }
}
