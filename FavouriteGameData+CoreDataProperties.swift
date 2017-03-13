//
//  FavouriteGameData+CoreDataProperties.swift
//  Find The Fun
//
//  Created by Andrea & Beatrice on 13/03/17.
//  Copyright © 2017 Andrea. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension FavouriteGameData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavouriteGameData> {
        return NSFetchRequest<FavouriteGameData>(entityName: "FavouriteGameData");
    }

    @NSManaged public var developers: String?
    @NSManaged public var gamemode: String?
    @NSManaged public var genre: String?
    @NSManaged public var id: Int32
    @NSManaged public var image: NSData?
    @NSManaged public var internetPage: String?
    @NSManaged public var name: String?
    @NSManaged public var publishers: String?
    @NSManaged public var rating: Int16
    @NSManaged public var summary: String?
    @NSManaged public var companies: NSSet?
    @NSManaged public var gamesmode: NSSet?
    @NSManaged public var genres: NSSet?

}

// MARK: Generated accessors for companies
extension FavouriteGameData {

    @objc(addCompaniesObject:)
    @NSManaged public func addToCompanies(_ value: CompanyData)

    @objc(removeCompaniesObject:)
    @NSManaged public func removeFromCompanies(_ value: CompanyData)

    @objc(addCompanies:)
    @NSManaged public func addToCompanies(_ values: NSSet)

    @objc(removeCompanies:)
    @NSManaged public func removeFromCompanies(_ values: NSSet)

}

// MARK: Generated accessors for gamesmode
extension FavouriteGameData {

    @objc(addGamesmodeObject:)
    @NSManaged public func addToGamesmode(_ value: GameModeData)

    @objc(removeGamesmodeObject:)
    @NSManaged public func removeFromGamesmode(_ value: GameModeData)

    @objc(addGamesmode:)
    @NSManaged public func addToGamesmode(_ values: NSSet)

    @objc(removeGamesmode:)
    @NSManaged public func removeFromGamesmode(_ values: NSSet)

}

// MARK: Generated accessors for genres
extension FavouriteGameData {

    @objc(addGenresObject:)
    @NSManaged public func addToGenres(_ value: GenreData)

    @objc(removeGenresObject:)
    @NSManaged public func removeFromGenres(_ value: GenreData)

    @objc(addGenres:)
    @NSManaged public func addToGenres(_ values: NSSet)

    @objc(removeGenres:)
    @NSManaged public func removeFromGenres(_ values: NSSet)

}
