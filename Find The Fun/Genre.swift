import Foundation
import UIKit
import Runes
import Argo
import Curry
import CoreData

struct Genres {
    //required
    let idGenre: Int //id
    let nameGenre: String //name
}

extension Genres: Decodable {
    static func decode(_ json: JSON) -> Decoded<Genres> {
        return curry(Genres.init)
            <^> json <| "id"
            <*> json <| "name"
    }
}

func saveGenre(idGenre: Int32, nameGenre: String) {
    
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    
    var arrayGenres: [NSManagedObject] = []
    let context = appDelegate.persistentContainer.viewContext
    let newGenre = NSEntityDescription.insertNewObject(forEntityName: "GenresData", into: context)
    
    newGenre.setValue(idGenre, forKey: "idGenre")
    newGenre.setValue(nameGenre, forKey: "nameGenre")
    
    do {
        try context.save()
        arrayGenres.append(newGenre)
    } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
    }
}

func fetchGenres(id: Int32) -> String? {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
    var stringOfGenre: String?
    let context = appDelegate.persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "GenresData")
    
    request.returnsObjectsAsFaults = false
    
    do {
        let results = try context.fetch(request)
        for result in results as! [NSManagedObject] {
            if id == result.value(forKey: "idGenre") as? Int32 {
                stringOfGenre = result.value(forKey: "nameGenre") as? String
                return stringOfGenre
            }
        }
    } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
    }
    return nil
}


func nameGenresDB(id: [Int], callback:@escaping (String) -> ()) {
    var genres: [String] = []
    id.forEach{ idGenre in
        if let nameGenre = fetchGenres(id: Int32(idGenre)) {
            genres.append(nameGenre)
        } else {
            let decodeJSON = DecodeJSON(url: getUrlIDGenres(idGenre: idGenre), apiKey: "ESZw4bgv1bmshrOge5OFyDGSG1BQp1vRtU9jsnrhB6thY2fEN5", httpHeaderField: "X-Mashape-Key")
            decodeJSON.getGenres(callback: { arrayGenres in
                arrayGenres.forEach({
                    genres.append( $0.nameGenre )
                    saveGenre(idGenre: Int32($0.idGenre), nameGenre: $0.nameGenre)
                })
            })
            
        }
    }
    callback(genres.joined(separator: "-"))
}
