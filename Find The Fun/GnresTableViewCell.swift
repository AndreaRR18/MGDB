import UIKit

class GnresTableViewCell: UITableViewCell {

    @IBOutlet weak var gnres: UILabel?
    
    static var gnresTableViewCellIdentifier: String { return "GnresTableViewCell" }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
