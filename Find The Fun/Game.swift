import Foundation
import UIKit
import Runes
import Argo
import Curry
import CoreData

struct Game {
    let idGame: Int   //id
    let name: String  //name
    
    let summary: String? //summary
    let rating: Int? //rating
    let developers: [Int]?  //developers
    let updatedAt: Int? //updated_at
    let releaseDate: [ReleaseDate]?  //release_dates
    let cover: Cover? //cover
    let genres: [Int]? //genres
    let gameModes: [Int]? //GameModes
    let screenshots: [Screenshot]? //screenshots
    let internetPage: String? //url
    let videos: [Video]? //videos
}







//------------Decode JSON with Argo-------------
extension Game: Decodable {
    static func decode(_ json: JSON) -> Decoded<Game> {
        return curry(Game.init)
            <^> json <| "id"
            <*> json <| "name"
            <*> json <|? "summary"
            <*> json <|? "rating"
            <*> json <||? "developers"
            <*> json <|? "updated_at"
            <*> json <||? "release_dates"
            <*> json <|? "cover"
            <*> json <||? "genres"
            <*> json <||? "game_modes"
            <*> json <||? "screenshots"
            <*> json <|? "url"
            <*> json <||? "videos"
        
    }
}






