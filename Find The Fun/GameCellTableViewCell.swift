import UIKit

class GameCellTableViewCell: UITableViewCell {

    
    @IBOutlet weak private var cover: UIImageView?
    @IBOutlet weak private var name: UILabel?
    @IBOutlet weak private var years: UILabel?
    @IBOutlet weak private var ratingStar: UIProgressView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureGameCell(_ game: Game) {
        self.backgroundColor = ColorUI.background
        name?.textColor = ColorUI.text
        years?.textColor = ColorUI.text
        name?.text = game.name
        years?.text = game.releaseDate?.first?.year.map(String.init)
        
        ratingStar?.progress = Float(game.rating ?? 1) / Float(100)
        
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
    }

}
