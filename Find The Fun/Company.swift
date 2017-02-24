import Runes
import Argo
import Curry

struct Companies {
    let idCompany: Int //id
    let name: String //name
    
    let logo: LogoCompanies? //logo
}

extension Companies: Decodable {
    static func decode(_ json: JSON) -> Decoded<Companies> {
        return curry(Companies.init)
            <^> json <| "id"
            <*> json <| "name"
            <*> json <|? "logo"
    }
}

