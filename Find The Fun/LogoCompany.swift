import Runes
import Argo
import Curry

struct LogoCompanies {
    let url: String? //string
    let width: Int? //int
    let height: Int? //int
}

extension LogoCompanies: Decodable {
    static func decode(_ json: JSON) -> Decoded<LogoCompanies> {
        return curry(LogoCompanies.init)
            <^> json <|? "url"
            <*> json <|? "width"
            <*> json <|? "height"
    }
}
