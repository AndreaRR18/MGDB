//import Runes
//import Argo
//import Curry
//
//struct LogoCompany {
//    let url: String? //string
//    let width: Int? //int
//    let height: Int? //int
//}
//
//extension LogoCompany: Decodable {
//    static func decode(_ json: JSON) -> Decoded<LogoCompany> {
//        return curry(LogoCompany.init)
//            <^> json <|? "url"
//            <*> json <|? "width"
//            <*> json <|? "height"
//    }
//}
