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
    let rating: Int? //aggregated_rating
    let developers: [Int]?  //developers
    let publishers: [Int]? // publishers
    let updatedAt: Int? //updated_at
    let releaseDate: [ReleaseDate]?  //release_dates
    let cover: Cover? //cover
    let genres: [Int]? //genres
    let gameModes: [Int]? //game_modes
    let screenshots: [Screenshot]? //screenshots
    let internetPage: String? //url
    let videos: [Video]? //videos
}

extension Game: Decodable {
    static func decode(_ json: JSON) -> Decoded<Game> {
        return curry(Game.init)
            <^> json <| "id"
            <*> json <| "name"
            <*> json <|? "summary"
            <*> json <|? "aggregated_rating"
            <*> json <||? "developers"
            <*> json <||? "publishers"
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






