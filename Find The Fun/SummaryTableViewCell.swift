import UIKit

class SummaryTableViewCell: UITableViewCell {

    @IBOutlet weak var summary: UILabel?
    @IBOutlet weak var summaryText: UITextView?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var textSummary: String? {
        didSet {
            summaryText?.text = textSummary
            summaryText?.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
        }
    }
}
