import Foundation
import UIKit
import Runes
import Argo
import Curry
import CoreData

struct Platform {
    let idPlatform: Int //id
    let namePlatform: String //name
    
    let logoPlatform: LogoPlatform? //logo
}

extension Platform: Decodable {
    static func decode(_ json: JSON) -> Decoded<Platform> {
        return curry(Platform.init)
            <^> json <| "id"
            <*> json <| "name"
            <*> json <|? "logo"
    }
}

