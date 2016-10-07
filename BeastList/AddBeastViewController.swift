//
//  AddBeastViewController.swift
//  BeastList
//
//  Created by Curtis Wang on 9/23/16.
//  Copyright © 2016 Curtis Wang. All rights reserved.
//

import UIKit

class AddBeastViewController: UITableViewController {
    
    weak var cancelButtonDelegate: CancelButtonDelegate?
    weak var delegate: AddBeastViewControllerDelegate?
    var beastToEdit: Beast?

    @IBOutlet weak var beastTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Just Beast It"
        if let check = beastToEdit {
            beastTextField.text = beastToEdit!.name
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneButtonPressed(sender: UIBarButtonItem) {
        let beastName = beastTextField.text!
        if let beast = beastToEdit {
            beast.name = beastName
           delegate?.addBeastViewController(self, didFinishEditingBeast: beast)
        } else {
            delegate?.addBeastViewController(self, didFinishAddingBeast: beastName)
        }
    }
    
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        cancelButtonDelegate?.cancelButtonPressedFrom(self)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
