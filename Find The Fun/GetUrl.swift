import Foundation
import AlamofireImage
import UIKit
import Alamofire

func getCoverSmall(url: String?) -> URL? {
    guard let url = url else { return nil}
    return URL(string: "https:"+url.replacingOccurrences(of: "/t_thumb", with: "/t_cover_small"))
}

func getCoverMed(url: String?) -> URL? {
    guard let url = url else { return nil}
    return URL(string: "https:"+url.replacingOccurrences(of: "/t_thumb", with: "/t_cover_med"))
}

func getCoverBig(url: String?) -> URL? {
    guard let url = url else { return nil}
    return URL(string: "https:"+url.replacingOccurrences(of: "/t_thumb", with: "/t_cover_big"))
}

func getCover(url: String?) -> URL? {
    guard let url = url else { return nil}
    return URL(string: ("https:"+url).replacingOccurrences(of: "/t_thumb", with: "", options: .literal))
}

func getUrlSearchedGames(title: String?) -> String {
    guard let urlEncode = title?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)?.lowercased() else { return "" }
    return "https://igdbcom-internet-game-database-v1.p.mashape.com/games/?fields=id,name,summary,aggregated_rating,developers,publishers,updated_at,release_dates,cover,genres,game_modes,screenshots,url,videos&limit=50&filter[aggregated_rating][gt]=1&search="+urlEncode
}

func getUrlOffsetdGames(offset: Int) -> String {
    return "https://igdbcom-internet-game-database-v1.p.mashape.com/games/?fields=*&limit=10&order=updated_at%3Adesc&filter[aggregated_rating][gt]=1&offset="+"\(offset)"
}

func getUrlIDCompany(idCompany: Int) -> String {
    return "https://igdbcom-internet-game-database-v1.p.mashape.com/companies/"+"\(idCompany)"+"?fields=*"
}

func getUrlIDPlatform(idPlatform: Int) -> String {
     return "https://igdbcom-internet-game-database-v1.p.mashape.com/platforms/"+"\(idPlatform)"+"?fields=*"
}

func getHDImage(url: String?) -> URL? {
    guard let url = url else { return nil }
    return URL(string: ("https:"+url).replacingOccurrences(of: "/t_thumb", with: "", options: .literal))
}

func getUrlIDGame(idGame: String) -> String {
    return "https://igdbcom-internet-game-database-v1.p.mashape.com/games/"+"\(idGame)"+"?fields=*&filter[rating][gt]=1"
}

func getUrlIDGenres(idGenre: Int) -> String {
    return "https://igdbcom-internet-game-database-v1.p.mashape.com/genres/"+"\(idGenre)"+"?fields=*"
}

func getUrlIDGameModes(idGameModes: Int) -> String {
    return "https://igdbcom-internet-game-database-v1.p.mashape.com/game_modes/"+"\(idGameModes)"+"?fields=*"
}

func getLogoThumbnail(cloudinaryid: String?) -> URL? {
    guard let cloudinaryid = cloudinaryid else { return nil }
    return URL(string: ("https://images.igdb.com/igdb/image/upload/t_thumb/"+cloudinaryid).replacingOccurrences(of: "/t_thumb", with: "", options: .literal))
}

func getLogoHDCompany(cloudinaryid: String?) -> URL? {
    guard let cloudinaryid = cloudinaryid else { return nil }
    return URL(string: ("https://images.igdb.com/igdb/image/upload/"+cloudinaryid))
}

func getImagePreviewVideo(videoid: String?) -> URL? {
    guard let videoid = videoid else { return nil }
    return URL(string: "https://i.ytimg.com/vi/\(videoid)/hqdefault.jpg?custom=true&w=336&h=188&stc=true&jpg444=true&jpgq=90&sp=68&sigh=S3AfL9nWFAuBkXUjdexR4IUiavY")
}

func getVideo(videoid: String?) -> URL? {
    guard let videoid = videoid else { return nil }
    return URL(string: "https://www.youtube.com/embed/\(videoid)")
}
