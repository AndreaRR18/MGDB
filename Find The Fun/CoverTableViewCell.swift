import UIKit

class CoverTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnail: UIImageView?
    @IBOutlet weak var name: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbnail?.layer.cornerRadius = 30

    }
    
    var url: URL? {
        didSet {
            thumbnail?.af_setImage(
                withURL: url!,
                placeholderImage: #imageLiteral(resourceName: "img-not-found"),
                filter: nil,
                progress: nil,
                progressQueue: DispatchQueue.main,
                imageTransition: .crossDissolve(0.2),
                runImageTransitionIfCached: true,
                completion: { _ in
                    self.thumbnail?.layer.shadowColor = UIColor.black.cgColor
                    self.thumbnail?.layer.shadowOpacity = 3
                    self.thumbnail?.layer.shadowOffset = CGSize.zero
                    self.thumbnail?.layer.shadowRadius = 4
            })
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
