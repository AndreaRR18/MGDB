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



