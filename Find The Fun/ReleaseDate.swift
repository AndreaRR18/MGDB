import Runes
import Argo
import Curry

struct ReleaseDate {
    let platform: Int? //platform
    let year: Int? //y
    let human: String?
}

extension ReleaseDate: Decodable {
    static func decode(_ json: JSON) -> Decoded<ReleaseDate> {
        return curry(ReleaseDate.init)
            <^> json <|? "platform"
            <*> json <|? "y"
            <*> json <|? "human"
    }
}
