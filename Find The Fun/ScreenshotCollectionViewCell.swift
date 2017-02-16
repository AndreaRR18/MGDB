import UIKit

class ScreenshotCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var screenshotImage: UIImageView?
    static var screenshotImageReuseIdentifier: String { return "ScreenshotCollectionViewCell" }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var url: URL? {
        didSet{
            screenshotImage?.af_setImage(
                withURL: url!,
                placeholderImage: #imageLiteral(resourceName: "img-not-found"),
                filter: nil,
                progress: nil,
                progressQueue: DispatchQueue.main,
                imageTransition: UIImageView.ImageTransition.crossDissolve(0.1),
                runImageTransitionIfCached: true,
                completion: { _ in
            })
        }
    }

}
