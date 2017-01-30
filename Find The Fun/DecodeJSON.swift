import Foundation
import UIKit
import Argo


class DecodeJSON {
    let url: String
    var arrayGames: [Game]? = nil
    let apiKey: String
    let httpHeaderField: String
    
    var arrayCompanies: [Companies]? = nil
    
    var arrayPlatforms: [Platform]? = nil

    
    init(url: String, apiKey: String, httpHeaderField: String) {
        self.url = url
        self.apiKey = apiKey
        self.httpHeaderField = httpHeaderField
    }
    
    func getSearchGames(weak callback:@escaping ([Game]) -> ()) {
        if let arrayGamesExist = arrayGames {
            callback(arrayGamesExist)
        } else {
            if let url = URL(string: url) {
                let req = NSMutableURLRequest(url: url)
                req.setValue(apiKey, forHTTPHeaderField: httpHeaderField)
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
    
    func getNewGames(callback:@escaping ([Game]) -> ()) {
        if let arrayGamesExist = arrayGames {
            callback(arrayGamesExist)
        } else {
            if let url = URL(string: url) {
                let req = NSMutableURLRequest(url: url)
                req.setValue(apiKey, forHTTPHeaderField: httpHeaderField)
                let task = URLSession.shared.dataTask(with: req as URLRequest, completionHandler: {
                    (data, response, error) -> Void in
                    if let data = data {
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


    func getCompanies(callback:@escaping ([Companies]) -> ()) {
        if let arrayCompaniesExist = arrayCompanies {
            callback(arrayCompaniesExist)
        } else {
            if let url = URL(string: url) {
                let req = NSMutableURLRequest(url: url)
                req.setValue(apiKey, forHTTPHeaderField: httpHeaderField)
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
    
    func parsingJsonDataCompanies(data: Data) -> [Companies]? {
        var companies: [Companies]? = []
        let jsonResult: Any? = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
        if let j: Any = jsonResult {
            companies = decode(j)
        }
        return companies.flatMap{ $0 }
    }

    func getPlatform(callback:@escaping ([Platform]) -> ()) {
        if let arrayCompaniesExist = arrayPlatforms {
            callback(arrayCompaniesExist)
        } else {
            if let url = URL(string: url) {
                let req = NSMutableURLRequest(url: url)
                req.setValue(apiKey, forHTTPHeaderField: httpHeaderField)
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



}





