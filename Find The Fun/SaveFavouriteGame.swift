import Foundation
import CoreData
import UIKit



func saveFavouriteGame(game: Game, platform: Int, company: Int) {
    
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    
    var arrayFavouriteGames: [NSManagedObject] = []
    let context = appDelegate.persistentContainer.viewContext
    let newFavuoriteGame = NSEntityDescription.insertNewObject(forEntityName: "FavouriteGameData", into: context)
    
    newFavuoriteGame.setValue(game.idGame, forKey: "id")
    newFavuoriteGame.setValue(game.name, forKey: "name")
    newFavuoriteGame.setValue(game.rating, forKey: "rating")
    newFavuoriteGame.setValue(game.summary, forKey: "summary")
    newFavuoriteGame.setValue(game.releaseDate?.first?.year, forKey: "firstReleaseDate")
    newFavuoriteGame.setValue(platform, forKey: "platform")
    newFavuoriteGame.setValue(company, forKey: "company")
    
    do {
        try context.save()
        arrayFavouriteGames.append(newFavuoriteGame)
    } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
    }
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

