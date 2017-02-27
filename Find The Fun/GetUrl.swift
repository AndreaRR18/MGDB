import Foundation
import AlamofireImage
import UIKit
import Alamofire

func getCoverSmall(url: String?) -> URL? {
    guard let url = url else { return nil }
    let urlHttps = URL(string: "https:"+url.replacingOccurrences(of: "/t_thumb", with: "/t_cover_small"))
    return urlHttps
}

func getCoverMed(url: String?) -> URL? {
    guard let url = url else { return nil }
    let urlHttps = URL(string: "https:"+url.replacingOccurrences(of: "/t_thumb", with: "/t_cover_med"))
    return urlHttps
}

func getCoverBig(url: String?) -> URL? {
    guard let url = url else { return nil }
    let urlHttps = URL(string: "https:"+url.replacingOccurrences(of: "/t_thumb", with: "/t_cover_big"))
    return urlHttps
}

func getCover(url: String?) -> URL? {
    guard let url = url else { return nil }
    let urlHttps = URL(string: ("https:"+url).replacingOccurrences(of: "/t_thumb", with: "", options: .literal))
    return urlHttps
}

func getUrlSearchedGames(title: String) -> String {
    let urlEncode = title.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    let gamesURLSearch = "https://igdbcom-internet-game-database-v1.p.mashape.com/games/?fields=*&limit=50&filter[rating][gt]=1&search="+urlEncode!
    return gamesURLSearch
}

func getUrlOffsetdGames(offset: Int) -> String {
    let gamesURLOffset = "https://igdbcom-internet-game-database-v1.p.mashape.com/games/?fields=*&limit=10&order=updated_at%3Adesc&filter[rating][gt]=1&offset="+"\(offset)"
    return gamesURLOffset
}

func getUrlIDCompany(idCompany: Int) -> String {
    let companiesUrl = "https://igdbcom-internet-game-database-v1.p.mashape.com/companies/"+"\(idCompany)"+"?fields=*"
    return companiesUrl
}

func getUrlIDPlatform(idPlatform: Int) -> String {
    let platformUrl = "https://igdbcom-internet-game-database-v1.p.mashape.com/platforms/"+"\(idPlatform)"+"?fields=*"
    return platformUrl
}

func getHDImage(url: String?) -> URL? {
    guard let url = url else { return nil }
    let urlHttps = URL(string: ("https:"+url).replacingOccurrences(of: "/t_thumb", with: "", options: .literal))
    return urlHttps
}

func getUrlIDGame(idGame: String) -> String {
    let gameUrl = "https://igdbcom-internet-game-database-v1.p.mashape.com/games/"+"\(idGame)"+"?fields=*&filter[rating][gt]=1"
    return gameUrl
}

func getUrlIDGenres(idGenre: Int) -> String {
    let genresUrl = "https://igdbcom-internet-game-database-v1.p.mashape.com/genres/"+"\(idGenre)"+"?fields=*"
    return genresUrl
}

func getUrlIDGameModes(idGameModes: Int) -> String {
    let gameModesUrl = "https://igdbcom-internet-game-database-v1.p.mashape.com/game_modes/"+"\(idGameModes)"+"?fields=*"
    return gameModesUrl
}

func getLogoThumbnail(cloudinaryid: String?) -> URL? {
    guard let cloudinaryid = cloudinaryid else { return nil }
    let urlLogoThumbnail = URL(string: ("https://images.igdb.com/igdb/image/upload/t_thumb/"+cloudinaryid).replacingOccurrences(of: "/t_thumb", with: "", options: .literal))
    return urlLogoThumbnail
}

func getLogoHDCompany(cloudinaryid: String?) -> URL? {
    guard let cloudinaryid = cloudinaryid else { return nil }
    let urlLogoHDCompany = URL(string: ("https://images.igdb.com/igdb/image/upload/"+cloudinaryid))
    return urlLogoHDCompany
}

func getImagePreviewVideo(videoid: String?) -> URL? {
    guard let videoid = videoid else { return nil }
    let urlPreviewVideo = URL(string: "https://i.ytimg.com/vi/\(videoid)/hqdefault.jpg?custom=true&w=336&h=188&stc=true&jpg444=true&jpgq=90&sp=68&sigh=S3AfL9nWFAuBkXUjdexR4IUiavY")
    return urlPreviewVideo
}

func getVideo(videoid: String?) -> URL? {
    guard let videoid = videoid else { return nil }
    let urlVideo = URL(string: "https://www.youtube.com/embed/\(videoid)")
    return urlVideo
}
