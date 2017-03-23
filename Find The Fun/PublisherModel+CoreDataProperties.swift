//
//  PublisherModel+CoreDataProperties.swift
//  MGDB
//
//  Created by Andrea & Beatrice on 23/03/17.
//  Copyright © 2017 Andrea. All rights reserved.
//

import Foundation
import CoreData


extension PublisherModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PublisherModel> {
        return NSFetchRequest<PublisherModel>(entityName: "PublisherModel");
    }

    @NSManaged public var name: String?
    @NSManaged public var relationship: GameModel?

}
