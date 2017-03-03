import Runes
import Argo
import Curry

struct Platform {
    let idPlatform: Int //id
    let namePlatform: String //name
    let games: [Int]?
    let logoPlatform: LogoPlatform? //logo
}

extension Platform: Decodable {
    static func decode(_ json: JSON) -> Decoded<Platform> {
        return curry(Platform.init)
            <^> json <| "id"
            <*> json <| "name"
            <*> json <||? "games"
            <*> json <|? "logo"
    }
}

