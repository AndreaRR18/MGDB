import Runes
import Argo
import Curry

struct GameMode {
    //required
    let idGameModes: Int //id
    let nameGameModes: String //name
}

extension GameMode: Decodable {
    static func decode(_ json: JSON) -> Decoded<GameMode> {
        return curry(GameMode.init)
            <^> json <| "id"
            <*> json <| "name"
    }
}
