//
//  Game+CoreDataProperties.swift
//  MGDB
//
//  Created by Andrea & Beatrice on 23/03/17.
//  Copyright © 2017 Andrea. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Game {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Game> {
        return NSFetchRequest<Game>(entityName: "Game");
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var rating: Int16
    @NSManaged public var summary: String?
    @NSManaged public var cover: NSData?
    @NSManaged public var internetPage: String?
    @NSManaged public var publishers: Publisher?
    @NSManaged public var developers: Developer?
    @NSManaged public var genres: Genre?

}
