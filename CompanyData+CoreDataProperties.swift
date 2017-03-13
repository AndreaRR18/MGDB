//
//  CompanyData+CoreDataProperties.swift
//  Find The Fun
//
//  Created by Andrea & Beatrice on 13/03/17.
//  Copyright © 2017 Andrea. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension CompanyData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CompanyData> {
        return NSFetchRequest<CompanyData>(entityName: "CompanyData");
    }

    @NSManaged public var idCompany: Int32
    @NSManaged public var nameCompany: String?
    @NSManaged public var favouritegame: NSSet?

}

// MARK: Generated accessors for favouritegame
extension CompanyData {

    @objc(addFavouritegameObject:)
    @NSManaged public func addToFavouritegame(_ value: FavouriteGameData)

    @objc(removeFavouritegameObject:)
    @NSManaged public func removeFromFavouritegame(_ value: FavouriteGameData)

    @objc(addFavouritegame:)
    @NSManaged public func addToFavouritegame(_ values: NSSet)

    @objc(removeFavouritegame:)
    @NSManaged public func removeFromFavouritegame(_ values: NSSet)

}
