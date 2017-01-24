import Foundation
import AlamofireImage
import UIKit
import Alamofire

func getUrlHttps(url: String?) -> URL? {
    if let url = url {
        let urlHttps = URL(string: "https:"+url)
        return urlHttps
    } else {
        return nil
    }
    
}

//func getImageFromUrl(url: URL, placeholderImage: UIImage, callback:@escaping (UIImage) -> ()) {
//    let imageView: UIImageView? = nil
//    
//    imageView?.af_setImage(
//        withURL: url,
//        placeholderImage: placeholderImage,
//        progressQueue: DispatchQueue.main.async {
//            if let imageDownloaded = imageView {
//                callback(imageDownloaded)
//            }
//        },
//        imageTransition: .crossDissolve(0.5)
//        runImageTransitionIfCached: true,
//        completion: { (<#DataResponse<UIImage>#>) in
//            <#code#>
//    }
//    )
//}


