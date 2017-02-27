import UIKit

class CoverHDTableViewCell: UITableViewCell {

    @IBOutlet weak var coverHQ: UIImageView?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var url: URL? {
        didSet {
            coverHQ?.af_setImage(
                withURL: url!,
                placeholderImage: #imageLiteral(resourceName: "img-not-found"),
                filter: nil,
                progress: nil,
                progressQueue: DispatchQueue.main,
                imageTransition: .crossDissolve(0.1),
                runImageTransitionIfCached: true,
                completion: { _ in
                    guard let coverHQ = self.coverHQ else { return }
                    let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.init(rawValue: 10)!)
                    let blurEffectView = UIVisualEffectView(effect: blurEffect)
                    blurEffectView.frame = coverHQ.bounds
                    blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                    self.coverHQ?.addSubview(blurEffectView)
                    
            })
        }
    } 
}
