import UIKit

class GameModesTableViewCell: UITableViewCell {

    @IBOutlet weak var gameModes: UILabel?
    
    static var gameModesTableViewCellIdentifier: String { return "GameModesTableViewCell" }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
