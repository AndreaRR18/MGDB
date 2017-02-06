import Foundation
import AlamofireImage
import UIKit
import Alamofire

func getUrlHttps(url: String?) -> URL? {
    guard let url = url else { return nil }
    let urlHttps = URL(string: "https:"+url)
    return urlHttps
}

func getCover(url: String?) -> URL? {
    guard let url = url else { return nil }
    let urlHttps = URL(string: ("https:"+url).replacingOccurrences(of: "/t_thumb", with: "", options: .literal))
    return urlHttps
}

func getUrlSearchedGames(title: String) -> String {
    let urlEncode = title.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    let gamesURLSearch = "https://igdbcom-internet-game-database-v1.p.mashape.com/games/?fields=*&limit=50&order=release_dates.date%3Adesc&search="+urlEncode!
    return gamesURLSearch
}

func getUrlOffsetdGames(offset: Int) -> String {
    let gamesURLOffset = "https://igdbcom-internet-game-database-v1.p.mashape.com/games/?fields=*&limit=10&order=release_dates.date%3Adesc&offset="+"\(offset)"
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

func getScreenshots(url: String?) -> URL? {
    guard let url = url else { return nil }
    let urlHttps = URL(string: ("https:"+url).replacingOccurrences(of: "/t_thumb", with: "", options: .literal))
    return urlHttps
}

func getUrlIDGame(idGame: Int) -> String {
    let gameUrl = "https://igdbcom-internet-game-database-v1.p.mashape.com/games/"+"\(idGame)"+"?fields=*"
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


