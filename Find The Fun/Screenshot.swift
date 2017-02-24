import Runes
import Argo
import Curry

struct Screenshot {
    let url: String? //url
    let width: Int? //width
    let height: Int? //height
}

extension Screenshot: Decodable {
    static func decode(_ json: JSON) -> Decoded<Screenshot> {
        return curry(Screenshot.init)
            <^> json <|? "url"
            <*> json <|? "width"
            <*> json <|? "height"
    }
}
