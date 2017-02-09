import UIKit

class PlayTableViewCell: UITableViewCell {
    
    @IBOutlet weak var previewVideo: UIImageView?
    @IBOutlet weak var titleVideo: UILabel?
    
    static var cellPlayCellIdentifier: String { return "PlayTableViewCell" }
    
    var url: URL? {
        didSet{
            previewVideo?.af_setImage(
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
