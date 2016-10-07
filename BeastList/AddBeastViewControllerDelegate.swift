//
//  AddBeastViewControllerDelegate.swift
//  BeastList
//
//  Created by Curtis Wang on 9/12/16.
//  Copyright © 2016 Curtis Wang. All rights reserved.
//

import Foundation
protocol AddBeastViewControllerDelegate: class {
    func addBeastViewController(controller: AddBeastViewController, didFinishAddingBeast beast: String)
    func addBeastViewController(controller: AddBeastViewController, didFinishEditingBeast beast: Beast)
}