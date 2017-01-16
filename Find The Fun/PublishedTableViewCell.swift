import UIKit

class PublishedTableViewCell: UITableViewCell {

    @IBOutlet weak var firstReleaseDate: UILabel?
    
    static var publishedTableViewCellIdentifier: String { return "PublishedTableViewCell" }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
