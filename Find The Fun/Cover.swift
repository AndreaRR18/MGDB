import Runes
import Argo
import Curry

struct Cover {
    let url: String? //url
}

extension Cover: Decodable {
    static func decode(_ json: JSON) -> Decoded<Cover> {
        return curry(Cover.init)
            <^> json <|? "url"
    }
}
