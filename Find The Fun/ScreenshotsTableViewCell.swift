import UIKit

class ScreenshotsTableViewCell: UITableViewCell {

    @IBOutlet weak var screenshots: UILabel?
    
    static var screenshotsTableViewCellIdentifier: String { return "ScreenshotsTableViewCell" }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
