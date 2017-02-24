import Runes
import Argo
import Curry

struct Video {
    let name: String? //name
    let video_id: String? //video_id
}

extension Video: Decodable {
    static func decode(_ json: JSON) -> Decoded<Video> {
        return curry(Video.init)
            <^> json <|? "name"
            <*> json <|? "video_id"
    }
}
