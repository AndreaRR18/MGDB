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
}
