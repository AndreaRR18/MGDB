import Foundation
import UIKit
import Runes
import Argo
import Curry
import CoreData

struct GameModes {
    //required
    let idGameModes: Int //id
    let nameGameModes: String //name
}

extension GameModes: Decodable {
    static func decode(_ json: JSON) -> Decoded<GameModes> {
        return curry(GameModes.init)
            <^> json <| "id"
            <*> json <| "name"
    }
}

func saveGameModes(idGameModes: Int32, nameGameModes: String) {
    
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

func fetchGameModes(id: Int32) -> String? {
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


func nameGameModessDB(id: [Int], callback:@escaping (String) -> ()) {
    var gameModes: [String] = []
    id.forEach{ idGameModes in
        if let nameGameModes = fetchGameModes(id: Int32(idGameModes)) {
            gameModes.append(nameGameModes)
        } else {
            let decodeJSON = DecodeJSON(url: getUrlIDGameModes(idGameModes: idGameModes), apiKey: "ESZw4bgv1bmshrOge5OFyDGSG1BQp1vRtU9jsnrhB6thY2fEN5", httpHeaderField: "X-Mashape-Key")
            decodeJSON.getGameModes(callback: { arrayGameModes in
                arrayGameModes.forEach({
                    gameModes.append( $0.nameGameModes )
                    saveGameModes(idGameModes: Int32($0.idGameModes), nameGameModes: $0.nameGameModes)
                })
            })
            
        }
    }
    callback(gameModes.joined(separator: "-"))
}
