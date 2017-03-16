import UIKit

class ScreenshotTableCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak private var screenshotImage: UIImageView?
    
    static var screenshotCollectionIdentifier: String { return "ScreenshotTableCollectionViewCell" }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var url: URL? {
        didSet{
            guard let url = url else { return }
            
            let activitiIndicator = ActivityIndicator(view: screenshotImage)
            
            activitiIndicator.startAnimating()
            
            screenshotImage?.af_setImage(
                withURL: url,
                placeholderImage: #imageLiteral(resourceName: "img-not-found"),
                filter: nil,
                progress: nil,
                progressQueue: DispatchQueue.main,
                imageTransition: UIImageView.ImageTransition.crossDissolve(0.1),
                runImageTransitionIfCached: true,
                completion: { _ in
                    activitiIndicator.stopAnimating()
            })
        }
    }
}
