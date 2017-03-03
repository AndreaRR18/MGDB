import UIKit

class SummaryTableViewCell: UITableViewCell {

    @IBOutlet weak private var summary: UILabel?
    @IBOutlet weak private var summaryText: UITextView?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
//    var attrStr = try! NSAttributedString(
//        data: "<b><i>text</i></b>".dataUsingEncoding(NSUnicodeStringEncoding, allowLossyConversion: true)!,
//        options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
//        documentAttributes: nil)
//    label.attributedText = attrStr
    
    func configureSummaryTableViewCell(_ summary: String?) {
        self.backgroundColor = ColorUI.background
        summaryText?.text = summary
        summaryText?.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
        summaryText?.textColor = ColorUI.text
    }
}
