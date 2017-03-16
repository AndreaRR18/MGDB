import Foundation
import UIKit
import Argo

class DecodeJSON {
    
    let url: String
    
    init(url: String) {
        
        self.url = url
        
    }
    
    //-------------------------------SearchGame-------------------------------
    
    func getSearchGames(weak callback:@escaping ([Game]) -> ()) {
        
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
                                guard let arrayGames = self.parsingJsonDataGame(data: data) else { return }
                                callback(arrayGames.filter { $0.cover != nil })
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
    
    //-------------------------------New Game-------------------------------
    
    func getNewGames(callback:@escaping ([Game]) -> ()) {
        
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
                                guard let arrayGames = self.parsingJsonDataGame(data: data) else  { return }
                                callback(arrayGames.filter { $0.cover != nil && $0.updatedAt != nil})
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
    
    
    
    //-------------------------------Companies-------------------------------
    
    
    func getCompanies(callback:@escaping ([Company]) -> ()) {
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
                                guard let arrayCompanies = self.parsingJsonDataCompanies(data: data) else  { return }
                                callback(arrayCompanies)
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
    
    
    func parsingJsonDataCompanies(data: Data) -> [Company]? {
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
    
    func getCompany(callback:@escaping (Company) -> ()) {
        
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
                                guard let company = self.parsingJsonDataCompany(data: data) else { return }
                                callback(company)
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
    
    func getPlatform(callback:@escaping ([Platform]) -> ()) {
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
                                guard let arrayPlatforms = self.parsingJsonDataPlatforms(data: data) else { return }
                                callback(arrayPlatforms)
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
    
    func getGenres(callback:@escaping ([Genre]) -> ()) {
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
                                guard let arrayGenres = self.parsingJsonDataGenres(data: data) else { return }
                                callback(arrayGenres)
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
    
    func getGameModes(callback:@escaping ([GameMode]) -> ()) {
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
                                guard let arrayGameModes = self.parsingJsonDataGameModes(data: data) else { return }
                                callback(arrayGameModes)
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
    
    func getGamesFromID(callback:@escaping (Game) -> ()) {
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
                                guard let games = self.parsingJsonDataRelatedGamesFromID(data: data)?.first else { return }
                                callback(games)
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
