import Foundation
import UIKit
import CoreData


func savePlatform(idPlatform: Int32, namePlatform: String) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    var arrayPlatform: [NSManagedObject] = []
    let context = appDelegate.persistentContainer.viewContext
    let newCompany = NSEntityDescription.insertNewObject(forEntityName: "PlatformsData", into: context)
    newCompany.setValue(idPlatform, forKey: "idPlatform")
    newCompany.setValue(namePlatform, forKey: "namePlatform")
    do {
        try context.save()
        arrayPlatform.append(newCompany)
    } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
    }
}

func fetchPlatform(id: Int32) -> String? {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
    var stringOfCompanies: String?
    let context = appDelegate.persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PlatformsData")
    request.returnsObjectsAsFaults = false
    do {
        let results = try context.fetch(request)
        for result in results as! [NSManagedObject] {
            if id == result.value(forKey: "idPlatform") as! Int32 {
                stringOfCompanies = result.value(forKey: "namePlatform") as? String
                return stringOfCompanies
            }
        }
    } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
    }
    return nil
}

func namePlatformDB(id: Int?, callback:@escaping (String) -> ()) {
    if let idPlatform = id {
        if let namePlatform = fetchPlatform(id: Int32(idPlatform)) {
            callback(namePlatform)
        } else {
            let decodeJSON = DecodeJSON(url: getUrlIDPlatform(idPlatform: idPlatform))
            decodeJSON.getPlatform(callback: { arrayPlatforms in
                guard let idPlatform = arrayPlatforms.first?.idPlatform, let namePlatform = arrayPlatforms.first?.namePlatform else { return }
                savePlatform(idPlatform: Int32(idPlatform), namePlatform: namePlatform)
                callback(namePlatform)
            })
        }
    } else {
        return callback("N.D.")
    }
}
