import UIKit

class CoverTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnail: UIImageView?
    @IBOutlet weak var name: UILabel?
    
    static var coverTableViewCellIdentifier: String { return "CoverTableViewCell" }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
