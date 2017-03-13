//
//  GenreData+CoreDataProperties.swift
//  Find The Fun
//
//  Created by Andrea & Beatrice on 13/03/17.
//  Copyright © 2017 Andrea. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension GenreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GenreData> {
        return NSFetchRequest<GenreData>(entityName: "GenreData");
    }

    @NSManaged public var idGenre: Int32
    @NSManaged public var nameGenre: String?
    @NSManaged public var favouritegames: NSSet?

}

// MARK: Generated accessors for favouritegames
extension GenreData {

    @objc(addFavouritegamesObject:)
    @NSManaged public func addToFavouritegames(_ value: FavouriteGameData)

    @objc(removeFavouritegamesObject:)
    @NSManaged public func removeFromFavouritegames(_ value: FavouriteGameData)

    @objc(addFavouritegames:)
    @NSManaged public func addToFavouritegames(_ values: NSSet)

    @objc(removeFavouritegames:)
    @NSManaged public func removeFromFavouritegames(_ values: NSSet)

}
