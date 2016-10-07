//
//  Beasted+CoreDataProperties.swift
//  BeastList
//
//  Created by Curtis Wang on 9/23/16.
//  Copyright © 2016 Curtis Wang. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Beasted {

    @NSManaged var name: String?
    @NSManaged var date: NSDate?

}
