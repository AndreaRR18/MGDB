import UIKit
import AlamofireImage

class PreviewScreenshotTableViewCell: UITableViewCell {

    @IBOutlet weak var previewScreenshot: UIImageView?
    
    static var cellReleaseDateCellIdentifier: String { return "PreviewScreenshotTableViewCell" }
    
    var url: URL? {
        didSet{
            previewScreenshot?.af_setImage(
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
