import UIKit

class VideoDescriptionCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleVideo: UILabel?
    @IBOutlet weak var thumbnailVideo: UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var url: URL? {
        didSet{
            guard let url = url else { return }
            let activitiIndicator = ActivityIndicator(view: thumbnailVideo)
            activitiIndicator.startAnimating()
            thumbnailVideo?.af_setImage(
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
