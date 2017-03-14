import Foundation
import UIKit
import CoreData

class GenreCoreData {
    
static func saveGenre(idGenre: Int32, nameGenre: String) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let context = appDelegate.persistentContainer.viewContext
    let newGenre = NSEntityDescription.insertNewObject(forEntityName: "GenreData", into: context)
    newGenre.setValue(idGenre, forKey: "idGenre")
    newGenre.setValue(nameGenre, forKey: "nameGenre")
    do {
        try context.save()
    } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
    }
}

static func fetchGenre(id: Int32) -> String? {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
    let context = appDelegate.persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "GenreData")
    request.returnsObjectsAsFaults = false
    do {
        let results = try context.fetch(request)
        for result in results as! [NSManagedObject] {
            if id == result.value(forKey: "idGenre") as? Int32 {
                return result.value(forKey: "nameGenre") as? String
            }
        }
    } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
    }
    return nil
}

static func nameGenreDB(id: [Int]?, callback:@escaping (String) -> ()) {
    var genres: [String] = []
    guard let id = id else { return }
    id.forEach{ idGenre in
        if let nameGenre = fetchGenre(id: Int32(idGenre)) {
            genres.append(nameGenre)
        } else {
            let decodeJSON = DecodeJSON(url: getUrlIDGenres(idGenre: idGenre))
            decodeJSON.getGenres(callback: { arrayGenres in
                arrayGenres.forEach({
                    genres.append( $0.nameGenre )
                    saveGenre(idGenre: Int32($0.idGenre), nameGenre: $0.nameGenre)
                })
            })
        }
    }
    callback(genres.joined(separator: ", "))
}

}
