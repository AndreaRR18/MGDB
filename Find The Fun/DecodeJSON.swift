import Foundation
import UIKit
import Argo

class DecodeJSON {
    
    let url: String
    
    init(url: String) {
        
        self.url = url
        
    }
    
    //-------------------------------SearchGame-------------------------------
    
    func getSearchGames(callback: @escaping (() throws -> ([Game])) -> ()) {
        
        if let url = URL(string: url) {
            let req = NSMutableURLRequest(url: url)
            req.setValue(
                IGDBKey.apiKey,
                forHTTPHeaderField: IGDBKey.header)
            
            let task = URLSession
                .shared
                .dataTask(
                    with: req as URLRequest,
                    completionHandler: { (data, response, error) -> Void in
                        if let data = data {
                            DispatchQueue.main.async {
                                if let arrayGames = self.parsingJsonDataGame(data: data) {
                                    callback {arrayGames.filter { $0.cover != nil } }
                                }else {
                                    callback { throw "Dati inconsistenti" }
                                }
                            }
                        } else {
                            callback { throw "\(error)" }
                        }
                })
            task.resume()
        } else {
            callback { throw "URL errato!" }
        }
    }
    
    //-------------------------------New Game-------------------------------
    
    func getNewGames(callback: @escaping (() throws -> ([Game])) -> ()) {
        
        //        let cacheJson = CacheGame(
        //            fileName: "data",
        //            fileExtension: .JSON,
        //            subDirectory: "NewGame",
        //            directory: .applicationSupportDirectory)
        
        if let url = URL(string: url) {
            let req = NSMutableURLRequest(url: url)
            req.setValue(
                IGDBKey.apiKey,
                forHTTPHeaderField: IGDBKey.header)
            
            let task = URLSession
                .shared
                .dataTask(
                    with: req as URLRequest,
                    completionHandler: { (data, response, error) -> Void in
                        if let data = data {
                            
                            //                            do {
                            //
                            //                                try cacheJson?.saveFile(dataForJson: data)
                            //
                            //                            } catch {
                            //
                            //                                print(error)
                            //
                            //                            }
                            
                            DispatchQueue.main.async {
                                if let arrayGames = self.parsingJsonDataGame(data: data) {
                                    callback { arrayGames.filter { $0.cover != nil && $0.updatedAt != nil} }
                                }else  {
                                    callback { throw "Dati inconsistenti!" }
                                }
                            }
                        } else {
                            callback { throw "\(error)" }
                        }
                })
            task.resume()
        } else {
            callback { throw "URL errato!" }
        }
    }
    
    
    func parsingJsonDataGame(data: Data) -> [Game]? {
        do {
            let deserialized = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            return decode(deserialized).flatMap{ $0 }
        }
        catch let error {
            print("--------")
            print(error)
            print("--------")
            return nil
        }
    }
    
    
    //-------------------------------Single Company-------------------------------
    
    func getCompany(callback: @escaping (() throws -> (Company)) -> ()) {
        
        if let url = URL(string: url) {
            let req = NSMutableURLRequest(url: url)
            req.setValue(
                IGDBKey.apiKey,
                forHTTPHeaderField: IGDBKey.header)
            let task = URLSession
                .shared
                .dataTask(
                    with: req as URLRequest,
                    completionHandler: { (data, response, error) -> Void in
                        if let data = data {
                            DispatchQueue.main.async {
                                if let company = self.parsingJsonDataCompany(data: data) {
                                    callback { company }
                                }else {
                                    callback { throw "Dati inconsistenti!" }
                                }
                            }
                        } else {
                            callback { throw "\(error)" }
                        }
                })
            task.resume()
        } else {
            callback { throw "URL errato!" }
        }
    }
    
    func parsingJsonDataCompany(data: Data) -> Company? {
        do {
            
            let deserialized = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            let array = try TypeCast.get(deserialized, as: [Any].self)
            let firstObject = try TypeCast.get(array.first, as: [String:Any].self)
            return try Company.decode(JSON(firstObject)).dematerialize()
        }
        catch let error {
            print("--------")
            print(error)
            print("--------")
            return nil
        }
    }
    
    
    //-------------------------------Platforms-------------------------------
    
    func getPlatform(callback: @escaping (() throws -> [Platform]) -> ()) {
        if let url = URL(string: url) {
            let req = NSMutableURLRequest(url: url)
            req.setValue(
                IGDBKey.apiKey,
                forHTTPHeaderField: IGDBKey.header)
            let task = URLSession
                .shared
                .dataTask(
                    with: req as URLRequest,
                    completionHandler: { (data, response, error) -> Void in
                        if let data = data {
                            DispatchQueue.main.async {
                                if let arrayPlatforms = self.parsingJsonDataPlatforms(data: data) {
                                    callback { arrayPlatforms }
                                }else {
                                    callback { throw "Dati inconsistenti!" }
                                }
                            }
                        } else {
                            callback { throw "\(error)" }
                        }
                })
            task.resume()
        } else {
            callback { throw "URL errato!" }
        }
    }
    
    
    func parsingJsonDataPlatforms(data: Data) -> [Platform]? {
        do {
            let deserialized = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            return decode(deserialized).flatMap{ $0 }
        }
        catch let error {
            print("--------")
            print(error)
            print("--------")
            return nil
        }
    }
    
    
    
    //-------------------------------Genres-------------------------------
    
    func getGenres(callback: @escaping ( () throws -> [Genre]) -> ()) {
        if let url = URL(string: url) {
            let req = NSMutableURLRequest(url: url)
            req.setValue(
                IGDBKey.apiKey,
                forHTTPHeaderField: IGDBKey.header)
            
            let task = URLSession
                .shared
                .dataTask(
                    with: req as URLRequest,
                    completionHandler: { (data, response, error) -> Void in
                        if let data = data {
                            DispatchQueue.main.async {
                                if let arrayGenres = self.parsingJsonDataGenres(data: data) {
                                    callback { arrayGenres }
                                }else {
                                    callback { throw "Dati inconsistenti" }
                                }
                            }
                        } else {
                            callback { throw "\(error)" }
                        }
                })
            task.resume()
        } else {
            callback { throw "URL errato!" }
        }
    }
    
    
    func parsingJsonDataGenres(data: Data) -> [Genre]? {
        do {
            let deserialized = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            return decode(deserialized).flatMap{ $0 }
        }
        catch let error {
            print("--------")
            print(error)
            print("--------")
            return nil
        }
    }
    
    
    //-------------------------------GameModes-------------------------------
    
    func getGameModes(callback:@escaping (() throws -> [GameMode]) -> ()) {
        if let url = URL(string: url) {
            let req = NSMutableURLRequest(url: url)
            req.setValue(
                IGDBKey.apiKey,
                forHTTPHeaderField: IGDBKey.header)
            let task = URLSession
                .shared
                .dataTask(
                    with: req as URLRequest,
                    completionHandler: { (data, response, error) -> Void in
                        if let data = data {
                            DispatchQueue.main.async {
                                if let arrayGameModes = self.parsingJsonDataGameModes(data: data) {
                                    callback { arrayGameModes }
                                }else {
                                    callback { throw "Dati inconsistenti!" }
                                }
                            }
                        } else {
                            callback { throw "\(error)" }
                        }
                })
            task.resume()
        } else {
            callback { throw "URL errato!" }
        }
    }
    
    
    func parsingJsonDataGameModes(data: Data) -> [GameMode]? {
        do {
            let deserialized = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            return decode(deserialized).flatMap{ $0 }
        }
        catch let error {
            print("--------")
            print(error)
            print("--------")
            return nil
        }
    }
    
    
    //-------------------------------Related Game-------------------------------
    
    func getGamesFromID(callback:@escaping (() throws -> (Game)) -> ()) {
        if let url = URL(string: url) {
            let req = NSMutableURLRequest(url: url)
            req.setValue(
                IGDBKey.apiKey,
                forHTTPHeaderField: IGDBKey.header)
            let task = URLSession
                .shared
                .dataTask(
                    with: req as URLRequest,
                    completionHandler: { (data, response, error) -> Void in
                        if let data = data {
                            DispatchQueue.main.async {
                                if let games = self.parsingJsonDataRelatedGamesFromID(data: data)?.first {
                                    callback { games }
                                }else {
                                    callback { throw "Dati inconsistenti!" }
                                }
                            }
                        } else {
                            callback { throw "\(error)" }
                        }
                })
            task.resume()
        } else {
            callback { throw "URL errato!" }
        }
    }
    
    
    func parsingJsonDataRelatedGamesFromID(data: Data) -> [Game]? {
        do {
            let deserialized = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            return decode(deserialized).flatMap{ $0 }
        }
        catch let error {
            print("--------")
            print(error)
            print("--------")
            return nil
        }
    }
}
