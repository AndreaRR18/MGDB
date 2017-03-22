import Foundation

class ProvideArray {
    
    static func newGames(callback: @escaping ([Game]) -> ()) {
        let decodedJSON = DecodeJSON(url: GetUrl.newGamesURL)
        decodedJSON.getNewGames(callback: { getNewGame in
            do {
                let arrayGames = try getNewGame()
                callback(arrayGames)
            } catch let error {
                print("\(error)")
            }
        })
        
    }
    
    
    static func seachGames(url: String, callback: @escaping ([Game]) -> ()) {
        let decodedJSON = DecodeJSON(url: url)
        decodedJSON.getSearchGames(callback: { getSearchGame in
            
            do {
                let arrayGames = try getSearchGame()
                callback(arrayGames)
            } catch let error {
                print("------------------------")
                print("\(error)")
                print("------------------------")
            }
        })
    }
    
    
    static func getCommonGames(idGenres: [Int], callback: @escaping (() throws -> ([Int])) -> ()) {
        
        let decodedJSON = DecodeJSON(url: GetUrl.getUrlIDGenres(stringOfIDGenres: idGenres.map(String.init).joined(separator: ",")))
        decodedJSON.getGenres( callback: { getGenre in
            do {
                let arrayGenre = try getGenre()
                
                guard let games = arrayGenre.first?.games.map(Set.init) else { return }
                var commonGames: [Int] = []
                for genre in arrayGenre {
                    commonGames = Array(games.intersection(Set(genre.games!)))
                }
                if commonGames.count > 50 {
                    callback { Array(commonGames[0...40])<-> }
                } else {
                    callback { commonGames<-> }
                }
                
            } catch let error {
                callback { throw error }
            }
        })
    }
}
