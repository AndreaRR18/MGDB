import Runes
import Argo
import Curry

struct Genre {
    //required
    let idGenre: Int //id
    let nameGenre: String //name
    let games: [Int]? //games
}

extension Genre: Decodable {
    static func decode(_ json: JSON) -> Decoded<Genre> {
        return curry(Genre.init)
            <^> json <| "id"
            <*> json <| "name"
            <*> json <||? "games"
    }
}

