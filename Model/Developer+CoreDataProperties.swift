//
//  Developer+CoreDataProperties.swift
//  MGDB
//
//  Created by Andrea & Beatrice on 23/03/17.
//  Copyright © 2017 Andrea. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Developer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Developer> {
        return NSFetchRequest<Developer>(entityName: "Developer");
    }

    @NSManaged public var name: String?

}
