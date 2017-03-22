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
    
    
//    static func takeCommonIDGames(idGenres: [Int], callback: @escaping(() throws -> ([Int])) -> ()) {
//        takeIdGames(idGenres: idGenres) { getTuple in
//            do {
//                let (arrayIDGames, arrayOfArrayIDGames) = try getTuple()
//                let arraySetIdGames = Set(arrayIDGames)
//                let arrayOfArraySetIdGames = arrayOfArrayIDGames.map(Set.init)
//                let commonElementSet = arrayOfArraySetIdGames.reduce(arraySetIdGames) { $0.intersection($1) }
//                
//                if commonElementSet.count > 100 {
//                    let arrayInt = Array(commonElementSet)<->
//                    let slice: [Int] = Array(arrayInt[0..<100])
//                    callback { slice }
//                } else {
//                    callback { Array(commonElementSet) }
//                }
//                
//            } catch let error {
//                print("\(error)")
//            }
//            
//        }
//    }




//func takeIdGames(idGenres: [Int], callback: @escaping (() throws -> (arrayIDGames: [Int], arrayOfArrayIDGames: [[Int]])) -> ()) {
//
//
//    idGenres.forEach{ genre in
//
//        var arrayOfArrayIDGames: [[Int]] = []
//        var arrayIDGames: [Int] = []
//        let decodedJSON = DecodeJSON(url: GetUrl.getUrlIDGenre(idGenre: genre))
//
//        decodedJSON.getGenres( callback: { getGenre in
//            do {
//                let arrayGenre = try getGenre()
//
//                guard let games = arrayGenre.first?.games else { return }
//                arrayIDGames += games
//                arrayOfArrayIDGames.append(games)
//                callback { (arrayIDGames, arrayOfArrayIDGames) }
//
//            } catch let error {
//                callback { throw error }
//            }
//        })
//    }
//}

