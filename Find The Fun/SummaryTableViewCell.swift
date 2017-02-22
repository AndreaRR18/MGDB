import UIKit

class SummaryTableViewCell: UITableViewCell {

    @IBOutlet weak var summary: UILabel?
    @IBOutlet weak var summaryText: UITextView?
    
    static var summaryTableViewCellIdentifier: String { return "SummaryTableViewCell" }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
