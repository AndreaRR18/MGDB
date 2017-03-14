import Runes
import Argo
import Curry

struct Screenshot {
    let url: String? //url
}

extension Screenshot: Decodable {
    static func decode(_ json: JSON) -> Decoded<Screenshot> {
        return curry(Screenshot.init)
            <^> json <|? "url"
    }
}
