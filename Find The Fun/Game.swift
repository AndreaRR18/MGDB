import Foundation
import UIKit
import Runes
import Argo
import Curry

struct Game {
    //required
    let idGame: Int   //id
    let name: String  //name
    
    //optional
    let summary: String? //summary
    let rating: Int? //rating
    let developers: [Int]?  //developers
    let updatedAt: Int? //updated_at
    let releaseDate: [ReleaseDate]?  //release_dates
    let cover: Cover? //cover
    let screenshots: [Screenshots]? //screenshots
    
    let identifier = GameCellTableViewCell.cellGameCellIdentifier
}

struct ReleaseDate {
    let platform: Int? //platform
    let year: Int? //y
    let month: Int? //m
}

struct Screenshots {
    let url: String? //url
    let width: Int? //width
    let height: Int? //height
}

struct Cover {
    let url: String? //url
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
            <*> json <||? "screenshots"
    }
}

extension ReleaseDate: Decodable {
    static func decode(_ json: JSON) -> Decoded<ReleaseDate> {
        return curry(ReleaseDate.init)
            <^> json <|? "platform"
            <*> json <|? "y"
            <*> json <|? "m"
    }
}

extension Screenshots: Decodable {
    static func decode(_ json: JSON) -> Decoded<Screenshots> {
        return curry(Screenshots.init)
        <^> json <|? "url"
        <*> json <|? "width"
        <*> json <|? "height"
    }
}

extension Cover: Decodable {
    static func decode(_ json: JSON) -> Decoded<Cover> {
        return curry(Cover.init)
            <^> json <|? "url"
    }
}



