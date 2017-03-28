import Foundation
import CoreData
import UIKit

func saveGameModel(game: Game, image: UIImage?) {
    
    guard let image = image else { return }
    
    let context = DatabaseController.persistentContainer.viewContext
    let gameToSave = GameModel(context: context)
    //    let gameToSave = FavouriteGameData(context: context)
    let developerToSave = DeveloperModel(context: context)
    let publisherToSave = PublisherModel(context: context)
    let genreToSave = GenreModel(context: context)
    let gameModeToSave = GameModeModel(context: context)
    
    let newCoverData: Data? = UIImageJPEGRepresentation(image, 1)
    gameToSave.cover = newCoverData as NSData?

    gameToSave.name = game.name
    gameToSave.id = Int16(game.idGame)
    gameToSave.summary = game.summary
    gameToSave.rating = Int16(game.rating ?? 50)
    gameToSave.internetPage = game.internetPage
    game.genres?.forEach { id in
       genreToSave.idGenre = Int16(id)
    }
    game.gameModes?.forEach { id in
        gameModeToSave.idGameMode = Int16(id)
    }
    game.developers?.forEach { id in
        developerToSave.idDeveloper = Int16(id)
    }
    game.publishers?.forEach { id in
        publisherToSave.idPublisher = Int16(id)
    }
    
    gameToSave.addToDevelopers(developerToSave)
    gameToSave.addToGenres(genreToSave)
    gameToSave.addToGameModes(gameModeToSave)
    gameToSave.addToPublishers(publisherToSave)
    
    do {
        try context.save()
    } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
    }
    
    
}



func deleteGameModel(id: Int32) {
    
    let context = DatabaseController.persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "GameModel")
    
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


func alreadySavedGameModel(id: Int32) -> Bool {
    
    let context = DatabaseController.persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "GameModel")
    
    request.returnsObjectsAsFaults = false
    
    do {
        let results = try context.fetch(request)
        
        for result in results as! [NSManagedObject] {
            if id == result.value(forKey: "id") as? Int32 {
                return true
            }
        }
    } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
    }
    
    return false
}

