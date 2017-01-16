import UIKit

class RatingTableViewCell: UITableViewCell {

    @IBOutlet weak var rate: UILabel?
    
    static var ratingTableViewCellIdentifier: String { return "RatingTableViewCell" }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
