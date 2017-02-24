import UIKit

class SummaryTableViewCell: UITableViewCell {

    @IBOutlet weak var summary: UILabel?
    @IBOutlet weak var summaryText: UITextView?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
