import Foundation
import UIKit
import Argo

class DecodeJSON {
    let url: String
    var arrayGames: [Game]? = nil
    var arrayCompanies: [Company]? = nil
    var arrayPlatforms: [Platform]? = nil
    var arrayGenres: [Genre]? = nil
    var arrayGameModes: [GameMode]? = nil
    
    init(url: String) {
        self.url = url
    }
    
    //-------------------------------SearchGame-------------------------------
    func getSearchGames(weak callback:@escaping ([Game]) -> ()) {
        if let arrayGamesExist = arrayGames {
            callback(arrayGamesExist)
        } else {
            if let url = URL(string: url) {
                let req = NSMutableURLRequest(url: url)
                req.setValue(IGDBKey.apiKey, forHTTPHeaderField: IGDBKey.header)
                let task = URLSession.shared.dataTask(with: req as URLRequest, completionHandler: {
                    (data, response, error) -> Void in
                    if let data = data {
                        self.arrayGames = self.parsingJsonDataGame(data: data)
                        DispatchQueue.main.async {
                            if let arrayGames = self.arrayGames {
                                callback(arrayGames
                                    .filter { $0.cover != nil && $0.summary != nil})
                            }
                        }
                    } else {
                        print("\(error)")
                    }
                })
                task.resume()
            } else {
                print("URL errato!")
            }
        }
    }
    
    //-------------------------------New Game-------------------------------
    func getNewGames(callback:@escaping ([Game]) -> ()) {
//        let cacheJson = CacheGame(fileName: "data", fileExtension: .JSON, subDirectory: "NewGame", directory: .applicationSupportDirectory)
        if let arrayGamesExist = arrayGames {
            callback(arrayGamesExist)
        } else {
            if let url = URL(string: url) {
                let req = NSMutableURLRequest(url: url)
                req.setValue(IGDBKey.apiKey, forHTTPHeaderField: IGDBKey.header)
                let task = URLSession.shared.dataTask(with: req as URLRequest, completionHandler: {
                    (data, response, error) -> Void in
                    if let data = data {
//                        do {
//                            try cacheJson.saveFile(dataForJson: data)
//                        } catch {
//                            print(error)
//                        }
                        self.arrayGames = self.parsingJsonDataGame(data: data)
                        DispatchQueue.main.async {
                            if let arrayGames = self.arrayGames {
                                callback(
                                    arrayGames
                                        .filter { $0.cover != nil && $0.summary != nil && $0.updatedAt != nil})
                            }
                        }
                    } else {
                        print("\(error)")
                    }
                })
                task.resume()
                
            } else {
                print("URL errato!")
            }
        }
    }
    
    func parsingJsonDataGame(data: Data) -> [Game]? {
        var games: [Game]? = []
        let jsonResult: Any? = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
        if let j: Any = jsonResult {
            games = decode(j)
        }
        return games.flatMap{ $0 }
    }
    
    //-------------------------------Companies-------------------------------
    func getCompanies(callback:@escaping ([Company]) -> ()) {
        if let arrayCompaniesExist = arrayCompanies {
            callback(arrayCompaniesExist)
        } else {
            if let url = URL(string: url) {
                let req = NSMutableURLRequest(url: url)
                req.setValue(IGDBKey.apiKey, forHTTPHeaderField: IGDBKey.header)
                let task = URLSession.shared.dataTask(with: req as URLRequest, completionHandler: {
                    (data, response, error) -> Void in
                    if let data = data {
                        self.arrayCompanies = self.parsingJsonDataCompanies(data: data)
                        DispatchQueue.main.async {
                            if let arrayCompanies = self.arrayCompanies {
                                callback(arrayCompanies)
                            }
                        }
                    } else {
                        print("\(error)")
                    }
                })
                task.resume()
                
            } else {
                print("URL errato!")
            }
        }
    }
    
    func parsingJsonDataCompanies(data: Data) -> [Company]? {
        var companies: [Company]? = []
        let jsonResult: Any? = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
        if let j: Any = jsonResult {
            companies = decode(j)
        }
        return companies.flatMap{ $0 }
    }
    
    //-------------------------------Platforms-------------------------------
    func getPlatform(callback:@escaping ([Platform]) -> ()) {
        if let arrayPlatform = arrayPlatforms {
            callback(arrayPlatform)
        } else {
            if let url = URL(string: url) {
                let req = NSMutableURLRequest(url: url)
                req.setValue(IGDBKey.apiKey, forHTTPHeaderField: IGDBKey.header)
                let task = URLSession.shared.dataTask(with: req as URLRequest, completionHandler: {
                    (data, response, error) -> Void in
                    if let data = data {
                        self.arrayPlatforms = self.parsingJsonDataPlatforms(data: data)
                        DispatchQueue.main.async {
                            if let arrayPlatforms = self.arrayPlatforms {
                                callback(arrayPlatforms)
                            }
                        }
                    } else {
                        print("\(error)")
                    }
                })
                task.resume()
                
            } else {
                print("URL errato!")
            }
        }
    }
    
    func parsingJsonDataPlatforms(data: Data) -> [Platform]? {
        var platform: [Platform]? = []
        let jsonResult: Any? = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
        if let j: Any = jsonResult {
            platform = decode(j)
        }
        return platform.flatMap{ $0 }
    }
    
    
    //-------------------------------Genres-------------------------------
    func getGenres(callback:@escaping ([Genre]) -> ()) {
        if let arrayGenre = arrayGenres {
            callback(arrayGenre)
        } else {
            if let url = URL(string: url) {
                let req = NSMutableURLRequest(url: url)
                req.setValue(IGDBKey.apiKey, forHTTPHeaderField: IGDBKey.header)
                let task = URLSession.shared.dataTask(with: req as URLRequest, completionHandler: {
                    (data, response, error) -> Void in
                    if let data = data {
                        self.arrayGenres = self.parsingJsonDataGenres(data: data)
                        DispatchQueue.main.async {
                            if let arrayGenres = self.arrayGenres {
                                callback(arrayGenres)
                            }
                        }
                    } else {
                        print("\(error)")
                    }
                })
                task.resume()
                
            } else {
                print("URL errato!")
            }
        }
    }
    
    func parsingJsonDataGenres(data: Data) -> [Genre]? {
        var genre: [Genre]? = []
        let jsonResult: Any? = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
        if let j: Any = jsonResult {
            genre = decode(j)
        }
        return genre.flatMap{ $0 }
    }
    
    //-------------------------------GameModes-------------------------------
    func getGameModes(callback:@escaping ([GameMode]) -> ()) {
        if let arrayGameModes = arrayGameModes {
            callback(arrayGameModes)
        } else {
            if let url = URL(string: url) {
                let req = NSMutableURLRequest(url: url)
                req.setValue(IGDBKey.apiKey, forHTTPHeaderField: IGDBKey.header)
                let task = URLSession.shared.dataTask(with: req as URLRequest, completionHandler: {
                    (data, response, error) -> Void in
                    if let data = data {
                        self.arrayGameModes = self.parsingJsonDataGameModes(data: data)
                        DispatchQueue.main.async {
                            if let arrayGameModes = self.arrayGameModes {
                                callback(arrayGameModes)
                            }
                        }
                    } else {
                        print("\(error)")
                    }
                })
                task.resume()
                
            } else {
                print("URL errato!")
            }
        }
    }
    
    func parsingJsonDataGameModes(data: Data) -> [GameMode]? {
        var gameModes: [GameMode]? = []
        let jsonResult: Any? = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
        if let j: Any = jsonResult {
            gameModes = decode(j)
        }
        return gameModes.flatMap{ $0 }
    }
    
    //-------------------------------Related Game-------------------------------
    func getGamesFromID(callback:@escaping (Game) -> ()) {
        if let url = URL(string: url) {
            let req = NSMutableURLRequest(url: url)
            req.setValue(IGDBKey.apiKey, forHTTPHeaderField: IGDBKey.header)
            let task = URLSession.shared.dataTask(with: req as URLRequest, completionHandler: {
                (data, response, error) -> Void in
                if let data = data {
                    self.arrayGames = self.parsingJsonDataRelatedGamesFromID(data: data)
                    DispatchQueue.main.async {
                        if let games = self.arrayGames?.first {
                            callback(games)
                        }
                    }
                } else {
                    print("\(error)")
                }
            })
            task.resume()
        } else {
            print("URL errato!")
        }
    }
    
    func parsingJsonDataRelatedGamesFromID(data: Data) -> [Game]? {
        var games: [Game]? = []
        let jsonResult: Any? = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
        if let j: Any = jsonResult {
            games = decode(j)
        }
        return games.flatMap{ $0 }
    }
    
}
