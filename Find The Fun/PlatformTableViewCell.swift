import UIKit

class PlatformTableViewCell: UITableViewCell {

    @IBOutlet weak var platform: UILabel?
    
    static var platformTableViewCellIdentifier: String { return "PlatformTableViewCell" }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
