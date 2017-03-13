import UIKit

protocol DeleteDelegate: class {
    func delete(idGame: Int32)
}
class FavouriteCollectionViewCell: UICollectionViewCell {

    private var game: FavouriteGameData? = nil

    @IBOutlet weak private var image: UIImageView?
    @IBOutlet weak private var title: UILabel?
    @IBOutlet weak private var ratingBar: UIProgressView?
    @IBOutlet weak private var year: UILabel?
    @IBOutlet weak var delete: UIImageView?
    
    @IBAction func deleteAction(_ sender: Any) {
        guard let game = game else { return }
        delegate?.delete(idGame: game.id)
    }
    
    weak var delegate: DeleteDelegate?
    
    func configureFavouriteGameCell(_ game: FavouriteGameData?) {
        self.backgroundColor = ColorUI.background
        delete?.image = UIImage(named: "delete")
        guard let game = game  else { return }
        image?.image = UIImage(data: game.image as! Data)
        title?.text = game.name
        year?.text = ""
        ratingBar?.progress = Float(game.rating) / Float(100)
        self.layer.borderWidth = 0.3
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.image?.layer.shadowColor = UIColor.black.cgColor
        self.image?.layer.shadowOpacity = 3
        self.image?.layer.shadowOffset = CGSize.zero
        self.image?.layer.shadowRadius = 10
        self.game = game
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
