import UIKit

class FavouriteCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak private var image: UIImageView?
    @IBOutlet weak private var title: UILabel?
    @IBOutlet weak private var ratingBar: UIProgressView?
    @IBOutlet weak private var year: UILabel?
    
    func configureFavouriteGameCell(_ game: FavouriteGameData?) {
        self.backgroundColor = ColorUI.background
        guard let game = game  else { return }
        image?.image = UIImage(data: game.image as! Data)
        title?.text = game.name
        year?.text = ""
        ratingBar?.progress = Float(game.rating) / Float(100)
        self.layer.borderWidth = 0.3
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
