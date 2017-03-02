import UIKit

class GameCellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var cover: UIImageView?
    @IBOutlet weak var name: UILabel?
    @IBOutlet weak var years: UILabel?
    @IBOutlet weak var ratingStar: UIProgressView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
//    var url: URL? {
//        didSet {
//            cover?.af_setImage(
//                withURL: url!,
//                placeholderImage: #imageLiteral(resourceName: "img-not-found"),
//                filter: nil,
//                progress: nil,
//                progressQueue: DispatchQueue.main,
//                imageTransition: .crossDissolve(0.1),
//                runImageTransitionIfCached: true,
//                completion: { _ in
//            })
//        }
//    }
//    
//    var rating: Float? {
//        didSet {
//            guard let rating = rating else { return }
//            let ratio = Float(rating) / Float(100)
//            ratingStar?.progress = ratio
//        }
//    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureGameCell(_ game: Game) {
        self.backgroundColor = ColorUI.background
        name?.textColor = ColorUI.text
        years?.textColor = ColorUI.text
        name?.text = game.name
        years?.text = game.releaseDate?.first?.year.map(String.init)
        
        let ratio = Float(game.rating ?? 1) / Float(100)
        ratingStar?.progress = ratio
        
        cover?.contentMode = .scaleAspectFit
        cover?.af_setImage(
            withURL: getCoverSmall(url: game.cover?.url)!,
            placeholderImage: #imageLiteral(resourceName: "img-not-found"),
            filter: nil,
            progress: nil,
            progressQueue: DispatchQueue.main,
            imageTransition: .crossDissolve(0.1),
            runImageTransitionIfCached: true,
            completion: { _ in
        })

//        url = getCoverSmall(url: game.cover?.url)
    }

}
