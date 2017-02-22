import Foundation
import CoreData
import UIKit
import AlamofireImage

func saveFavouriteGame(game: Game, image: UIImage) {
    
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    var arrayFavouriteGames: [NSManagedObject] = []
    let context = appDelegate.persistentContainer.viewContext
    let newFavuoriteGame = NSEntityDescription.insertNewObject(forEntityName: "FavouriteGameData", into: context)
    newFavuoriteGame.setValue(game.idGame, forKey: "id")
    newFavuoriteGame.setValue(game.name, forKey: "name")
    newFavuoriteGame.setValue(game.rating, forKey: "rating")
    newFavuoriteGame.setValue(game.summary, forKey: "summary")
    newFavuoriteGame.setValue(stringCompany(companyIDs: game.developers), forKey: "company")
    newFavuoriteGame.setValue(stringGenres(genresIDs: game.genres), forKey: "genre")
    newFavuoriteGame.setValue(stringGameModes(gameModesIDs: game.gameModes), forKey: "gamemode")
    let newCoverData: Data? = UIImageJPEGRepresentation(image, 1)
    newFavuoriteGame.setValue(newCoverData, forKey: "image")
    do {
        try context.save()
        arrayFavouriteGames.append(newFavuoriteGame)
    } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
    }
}

func stringCompany(companyIDs: [Int]?) -> String {
    var company = [String]()
    companyIDs?.forEach { id in
        guard let companyName = fetchCompany(id: Int32(id)) else { return }
        company.append(companyName)
    }
    return company.joined(separator: ", ")
}

func stringGenres(genresIDs: [Int]?) -> String {
    var genres = [String]()
    genresIDs?.forEach { id in
        guard let genresName = fetchGenres(id: Int32(id)) else { return }
        genres.append(genresName)
    }
    return genres.joined(separator: ", ")
}

func stringGameModes(gameModesIDs: [Int]?) -> String {
    var gameModes = [String]()
    gameModesIDs?.forEach { id in
        guard let gameModesName = fetchGameModes(id: Int32(id)) else { return }
        gameModes.append(gameModesName)
    }
    return gameModes.joined(separator: ", ")
}

func deleteFavouriteGame(id: Int32) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    
    let context = appDelegate.persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavouriteGameData")
    
    request.returnsObjectsAsFaults = false
    do {
        let results = try context.fetch(request)
        for result in results as! [NSManagedObject] {
            if id == result.value(forKey: "id") as? Int32 {
                context.delete(result)
            }
        }
    } catch let error as NSError {
        print("Could not delete. \(error), \(error.userInfo)")
    }
}

func fetchGameFavourite(id: Int32) -> Bool {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
    let context = appDelegate.persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavouriteGameData")
    
    request.returnsObjectsAsFaults = false
    
    do {
        let results = try context.fetch(request)
        for result in results as! [NSManagedObject] {
            if id == result.value(forKey: "id") as? Int32 {
                return false
            }
        }
    } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
    }
    return true
}

