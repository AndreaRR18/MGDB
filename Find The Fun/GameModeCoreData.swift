import Foundation
import UIKit
import CoreData

class GameModeCoreData {
    
    static func saveGameMode(idGameModes: Int32, nameGameModes: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        let newGameModes = NSEntityDescription.insertNewObject(forEntityName: "GameModeData", into: context)
        
        newGameModes.setValue(idGameModes, forKey: "idGameModes")
        newGameModes.setValue(nameGameModes, forKey: "nameGameModes")
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    static func fetchGameMode(id: Int32) -> String? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "GameModeData")
        
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            for result in results as! [NSManagedObject] {
                if id == result.value(forKey: "idGameModes") as? Int32 {
                    return result.value(forKey: "nameGameModes") as? String
                }
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return nil
    }
    
    
    static func nameGameModeDB(id: [Int], callback:@escaping (() throws -> (String)) -> ()) {
        var gamesMode: [String] = []
        
        id.forEach{ idGameMode in
            if let nameGameMode = fetchGameMode(id: Int32(idGameMode)) {
                gamesMode.append(nameGameMode)
            } else {
                let decodeJSON = DecodeJSON(url: GetUrl.getUrlIDGameModes(idGameModes: idGameMode))
                
                decodeJSON.getGameModes(callback: { getGameMode in
                    do {
                        let arrayGameMode = try getGameMode()
                        arrayGameMode.forEach({
                            gamesMode.append( $0.nameGameModes )
                            saveGameMode(idGameModes: Int32($0.idGameModes), nameGameModes: $0.nameGameModes)
                        })
                    } catch let error {
                        callback { throw error }
                    }
                })
            }
        }
        callback { gamesMode.joined(separator: ", ") }
    }
    
}
