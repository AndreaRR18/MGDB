import Foundation
import UIKit
import Argo


class DecodeGameJSON {
    let gamesURL: String
    var arrayGames: [Game]? = nil
    let apiKey: String
    let httpHeaderField: String
    
    init(gamesURL: String, apiKey: String, httpHeaderField: String) {
        self.gamesURL = gamesURL
        self.apiKey = apiKey
        self.httpHeaderField = httpHeaderField
    }
    
    func getSearchGames(callback:@escaping ([Game]) -> ()) {
        if let arrayGamesExist = arrayGames {
            callback(arrayGamesExist)
        } else {
            if let url = URL(string: gamesURL) {
                let req = NSMutableURLRequest(url: url)
                req.setValue(apiKey, forHTTPHeaderField: httpHeaderField)
                let task = URLSession.shared.dataTask(with: req as URLRequest, completionHandler: {
                    (data, response, error) -> Void in
                    if let data = data {
                        self.arrayGames = self.parsingJsonData(data: data)
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
            if let url = URL(string: gamesURL) {
                let req = NSMutableURLRequest(url: url)
                req.setValue(apiKey, forHTTPHeaderField: httpHeaderField)
                let task = URLSession.shared.dataTask(with: req as URLRequest, completionHandler: {
                    (data, response, error) -> Void in
                    if let data = data {
                        self.arrayGames = self.parsingJsonData(data: data)
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
    
    func parsingJsonData(data: Data) -> [Game] {
        var games: [Game]? = []
        let jsonResult: Any? = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
        if let j: Any = jsonResult {
            games = decode(j)
        }
        return games.flatMap{ $0 }!
    }
}


