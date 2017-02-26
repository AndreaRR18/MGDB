import UIKit

class GameCellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var cover: UIImageView?
    @IBOutlet weak var name: UILabel?
    @IBOutlet weak var years: UILabel?
    @IBOutlet weak var ratingStar: UIProgressView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        cover?.layer.cornerRadius = 20
//        cover?.layer.shadowColor = UIColor.black.cgColor
//        cover?.layer.shadowOpacity = 1
//        cover?.layer.shadowOffset = CGSize.zero
//        cover?.layer.shadowRadius = 10
    }
    
    var url: URL? {
        didSet {
            cover?.af_setImage(
                withURL: url!,
                placeholderImage: #imageLiteral(resourceName: "img-not-found"),
                filter: nil,
                progress: nil,
                progressQueue: DispatchQueue.main,
                imageTransition: .crossDissolve(0.2),
                runImageTransitionIfCached: true,
                completion: { _ in
            })
        }
    }
    
    var rating: Float? {
        didSet {
            guard let rating = rating else { return }
            let ratio = Float(rating) / Float(100)
            ratingStar?.progress = ratio
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
