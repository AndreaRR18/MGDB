import UIKit

class ReleaseDateTableViewCell: UITableViewCell {

    @IBOutlet weak var platform: UILabel?
    @IBOutlet weak var date: UILabel?
    @IBOutlet weak var logo: UIImageView?
    
    static var cellReleaseDateCellIdentifier: String { return "ReleaseDateTableViewCell" }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
