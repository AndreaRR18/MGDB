//
//  CompaniesDataModel+CoreDataProperties.swift
//  Find The Fun
//
//  Created by Andrea & Beatrice on 30/01/17.
//  Copyright © 2017 Andrea. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension CompaniesDataModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CompaniesDataModel> {
        return NSFetchRequest<CompaniesDataModel>(entityName: "CompaniesDataModel");
    }

    @NSManaged public var id: Int16
    @NSManaged public var nameCompanies: String?

}
