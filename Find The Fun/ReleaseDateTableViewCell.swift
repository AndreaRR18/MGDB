import UIKit

class ReleaseDateTableViewCell: UITableViewCell {
    
    @IBOutlet weak var platform: UILabel?
    @IBOutlet weak var date: UILabel?
    @IBOutlet weak var logo: UIImageView?
    
    var url: URL? {
        didSet{
            logo?.af_setImage(
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
