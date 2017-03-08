import UIKit

protocol FavouriteDelegate: class {
    func saveGame()
    func removeGame()
}

protocol ShareDelegate: class {
    func shareGame()
}

protocol ShowCoverDelegate: class {
    func showCover()
}

class CoverTableViewCell: UITableViewCell {
    
    @IBOutlet weak private var thumbnail: UIImageView?
    @IBOutlet weak private var name: UILabel?
    @IBOutlet weak private var ratingProgressView: UIProgressView?
    @IBOutlet weak var shareButton: UIButton?
    @IBOutlet weak var saveButton: UIButton?

    private var game: Game? = nil
    weak var favouriteDelegate: FavouriteDelegate?
    weak var shareDelegate: ShareDelegate?
    weak var showCoverDelegate: ShowCoverDelegate?

    @IBAction func showCover(_ sender: Any) {
        showCover()
    }
    
    @IBAction func share(_ sender: Any) {
        shareGame()

    }
    
    @IBAction func favourite(_ sender: Any) {
        if let id = game?.idGame, alreadySaved(id: Int32(id)) {
            removeGame()
        } else {
            saveGame()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        thumbnail?.layer.cornerRadius = 30
    }
    
    func configureCoverTableViewCell(_ game: Game?) {
        thumbnail?.af_setImage(
            withURL: getCoverMed(url: game?.cover?.url)!,
            placeholderImage: #imageLiteral(resourceName: "img-not-found"),
            filter: nil,
            progress: nil,
            progressQueue: DispatchQueue.main,
            imageTransition: .crossDissolve(0.1),
            runImageTransitionIfCached: true,
            completion: { _ in
                self.thumbnail?.layer.shadowColor = UIColor.black.cgColor
                self.thumbnail?.layer.shadowOpacity = 3
                self.thumbnail?.layer.shadowOffset = CGSize.zero
                self.thumbnail?.layer.shadowRadius = 4
        })
        name?.text = game?.name
        ratingProgressView?.progress = Float(game?.rating ?? 1) / Float(100)
        self.layer.zPosition = 3
        self.game = game
        if let game = game, alreadySaved(id: Int32(game.idGame)) {
            saveButton?.setImage(#imageLiteral(resourceName: "StarFull"), for: .normal)
            saveButton?.addTarget(self, action: #selector(self.removeGame), for: .touchUpInside)
        } else {
            saveButton?.setImage(#imageLiteral(resourceName: "StarEmpty"), for: .normal)
            saveButton?.addTarget(self, action: #selector(self.saveGame), for: .touchUpInside)
        }
        shareButton?.addTarget(self, action: #selector(self.shareGame), for: .touchUpInside)
    }
    
    func saveGame() {
      self.favouriteDelegate?.saveGame()
    }
    
    func removeGame() {
        self.favouriteDelegate?.removeGame()
    }
    
    func shareGame() {
        self.shareDelegate?.shareGame()
    }
    
    func showCover() {
        self.showCoverDelegate?.showCover()
    }
}
