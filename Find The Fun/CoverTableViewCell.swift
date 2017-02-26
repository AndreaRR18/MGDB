import UIKit

class CoverTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnail: UIImageView?
    @IBOutlet weak var name: UILabel?
    @IBOutlet weak var ratingProgressView: UIProgressView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbnail?.layer.cornerRadius = 30
    }
    
    var rating: Float? {
        didSet {
            guard let rating = rating else { return }
            let ratio = Float(rating) / Float(100)
            ratingProgressView?.progress = ratio
        }
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
}
