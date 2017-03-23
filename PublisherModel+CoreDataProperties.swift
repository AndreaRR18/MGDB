//
//  PublisherModel+CoreDataProperties.swift
//  MGDB
//
//  Created by Andrea & Beatrice on 23/03/17.
//  Copyright © 2017 Andrea. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension PublisherModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PublisherModel> {
        return NSFetchRequest<PublisherModel>(entityName: "PublisherModel");
    }

    @NSManaged public var name: String?

}
