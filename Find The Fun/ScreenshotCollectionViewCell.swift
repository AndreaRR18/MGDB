//import UIKit
//
//class ScreenshotCollectionViewCell: UICollectionViewCell {
//
//    @IBOutlet weak var screenshot: UIImageView?
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
//
//    var url: URL? {
//        didSet {
//            let activitiIndicator = ActivityIndicator(view: screenshot!)
//            activitiIndicator.startAnimating()
//            screenshot?.af_setImage(
//                withURL: url!,
//                placeholderImage: #imageLiteral(resourceName: "img-not-found"),
//                filter: nil,
//                progress: nil,
//                progressQueue: DispatchQueue.main,
//                imageTransition: .crossDissolve(0.1),
//                runImageTransitionIfCached: true,
//                completion: { _ in
//                    activitiIndicator.stopAnimating()
//            })
//            
//            
//        }
//    }
//
//}
