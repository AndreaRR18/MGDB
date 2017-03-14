import Foundation
import UIKit
import CoreData

class PlatformCoreData {
    
static func savePlatform(idPlatform: Int32, namePlatform: String) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let context = appDelegate.persistentContainer.viewContext
    let newCompany = NSEntityDescription.insertNewObject(forEntityName: "PlatformData", into: context)
    newCompany.setValue(idPlatform, forKey: "idPlatform")
    newCompany.setValue(namePlatform, forKey: "namePlatform")
    do {
        try context.save()
    } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
    }
}

static func fetchPlatform(id: Int32) -> String? {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
    let context = appDelegate.persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PlatformData")
    request.returnsObjectsAsFaults = false
    do {
        let results = try context.fetch(request)
        for result in results as! [NSManagedObject] {
            if id == result.value(forKey: "idPlatform") as! Int32 {
                return result.value(forKey: "namePlatform") as? String
            }
        }
    } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
    }
    return nil
}

static func namePlatformDB(id: Int?, callback:@escaping (String, Bool) -> ()) {
    var new = true
    if let idPlatform = id {
        if let namePlatform = fetchPlatform(id: Int32(idPlatform)) {
            new = false
            callback(namePlatform, new)
        } else {
            let decodeJSON = DecodeJSON(url: GetUrl.getUrlIDPlatform(idPlatform: idPlatform))
            decodeJSON.getPlatform(callback: { arrayPlatforms in
                guard let idPlatform = arrayPlatforms.first?.idPlatform, let namePlatform = arrayPlatforms.first?.namePlatform else { return }
                savePlatform(idPlatform: Int32(idPlatform), namePlatform: namePlatform)
                callback(namePlatform, new)
            })
        }
    } else {
        return callback("N.D.", new)
    }
}

}
