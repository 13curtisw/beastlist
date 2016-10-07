//
//  ViewController.swift
//  BeastList
//
//  Created by Curtis Wang on 9/23/16.
//  Copyright © 2016 Curtis Wang. All rights reserved.
//

import UIKit
import CoreData

class BeastViewController: UITableViewController, AddBeastViewControllerDelegate, CancelButtonDelegate {
    
    var beasts = [Beast]()
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllBeasts()
        self.title = "To Beast"
        
        
    }
    
    func fetchAllBeasts() {
        beasts = []
        let beastRequest = NSFetchRequest(entityName: "Beast")
        do {
            // get the results by executing the fetch request we made earlier
            let results = try managedObjectContext.executeFetchRequest(beastRequest)
            // downcast the results as an array of Beast objects
            let resultsArr = results as? [Beast]
            // print the details of each beast
            for beast in resultsArr! {
                beasts.append(beast)
            }
        } catch {
            // print the error if it is caught (Swift automatically saves the error in "error")
            print("\(error)")
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CustomCell") as! CustomCell
        cell.beastLabel.text = beasts[indexPath.row].name
        cell.beastButton.backgroundColor = UIColor.orangeColor()
        cell.beastButton.tag = indexPath.row
        return cell
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beasts.count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("EditSegue", sender: tableView.cellForRowAtIndexPath(indexPath))
    }
    
    func cancelButtonPressedFrom(controller: UIViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func addBeastViewController(controller: AddBeastViewController, didFinishAddingBeast beast: String) {
        dismissViewControllerAnimated(true, completion: nil)
        let newbeast = NSEntityDescription.insertNewObjectForEntityForName("Beast", inManagedObjectContext: managedObjectContext) as! Beast
        newbeast.name = beast
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
                print("Success")
                fetchAllBeasts()
            } catch {
                print("\(error)")
            }
        }
        tableView.reloadData()
    }
    func addBeastViewController(controller: AddBeastViewController, didFinishEditingBeast beast: Beast) {
        dismissViewControllerAnimated(true, completion: nil)
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
                print("Success")
                fetchAllBeasts()
            } catch {
                print("\(error)")
            }
        }
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        managedObjectContext.deleteObject(beasts[indexPath.row])
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
                print("Success")
                fetchAllBeasts()
            } catch {
                print("\(error)")
            }
        }
        tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AddSegue" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! AddBeastViewController
            controller.cancelButtonDelegate = self
            controller.delegate = self
        } else {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! AddBeastViewController
            controller.cancelButtonDelegate = self
            controller.delegate = self
            if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
                controller.beastToEdit = beasts[indexPath.row]
            }
        }
    }
    
    @IBAction func beastButtonPressed(sender: UIButton) {
        print(sender.tag)
        let newbeast = NSEntityDescription.insertNewObjectForEntityForName("Beasted", inManagedObjectContext: managedObjectContext) as! Beasted
        newbeast.name = beasts[sender.tag].name
        newbeast.date = NSDate()
        managedObjectContext.deleteObject(beasts[sender.tag])
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
                print("Success")
                fetchAllBeasts()
            } catch {
                print("\(error)")
            }
        }
        tableView.reloadData()

    }
    
    


}

