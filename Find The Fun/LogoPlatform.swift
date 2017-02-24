import Runes
import Argo
import Curry

struct LogoPlatform {
    //optional
    let url: String? //string
    let cloudinary_id: String?
    let width: Int? //int
    let height: Int? //int
}

extension LogoPlatform: Decodable {
    static func decode(_ json: JSON) -> Decoded<LogoPlatform> {
        return curry(LogoPlatform.init)
            <^> json <|? "url"
            <*> json <|? "cloudinary_id"
            <*> json <|? "width"
            <*> json <|? "height"
    }
}
