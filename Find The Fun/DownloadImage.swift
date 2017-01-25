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
    let gamesURLSearch = "https://igdbcom-internet-game-database-v1.p.mashape.com/games/?fields=*&limit=50"+"&search="+title.replacingOccurrences(of: " ", with: "")+"&order=release_dates.date%3Adesc"
    return gamesURLSearch
}


