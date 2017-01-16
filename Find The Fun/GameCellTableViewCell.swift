import UIKit

class GameCellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var cover: UIImageView?
    @IBOutlet weak var name: UILabel?
    @IBOutlet weak var categories: UILabel?
    @IBOutlet weak var developers: UILabel?
    @IBOutlet weak var years: UILabel?
    
    static var cellGameCellIdentifier: String { return "GameCellTableViewCell" }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
