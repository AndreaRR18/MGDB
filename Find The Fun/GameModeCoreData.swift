import Foundation
import UIKit
import CoreData

func saveGameMode(idGameModes: Int32, nameGameModes: String) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    var arrayGameModes: [NSManagedObject] = []
    let context = appDelegate.persistentContainer.viewContext
    let newGameModes = NSEntityDescription.insertNewObject(forEntityName: "GameModesData", into: context)
    newGameModes.setValue(idGameModes, forKey: "idGameModes")
    newGameModes.setValue(nameGameModes, forKey: "nameGameModes")
    do {
        try context.save()
        arrayGameModes.append(newGameModes)
    } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
    }
}

func fetchGameMode(id: Int32) -> String? {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
    var stringOfGameModes: String?
    let context = appDelegate.persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "GameModesData")
    request.returnsObjectsAsFaults = false
    do {
        let results = try context.fetch(request)
        for result in results as! [NSManagedObject] {
            if id == result.value(forKey: "idGameModes") as? Int32 {
                stringOfGameModes = result.value(forKey: "nameGameModes") as? String
                return stringOfGameModes
            }
        }
    } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
    }
    return nil
}


func nameGameModeDB(id: [Int]?, callback:@escaping (String) -> ()) {
    var gamesMode: [String] = []
    guard let id = id else { return }
    id.forEach{ idGameMode in
        if let nameGameMode = fetchGameMode(id: Int32(idGameMode)) {
            gamesMode.append(nameGameMode)
        } else {
            let decodeJSON = DecodeJSON(url: getUrlIDGameModes(idGameModes: idGameMode))
            decodeJSON.getGameModes(callback: { arrayGameMode in
                arrayGameMode.forEach({
                    gamesMode.append( $0.nameGameModes )
                    saveGameMode(idGameModes: Int32($0.idGameModes), nameGameModes: $0.nameGameModes)
                })
            })
            
        }
    }
    callback(gamesMode.joined(separator: ", "))
}
