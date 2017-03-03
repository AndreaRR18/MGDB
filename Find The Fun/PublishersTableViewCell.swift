import UIKit

class PublishersTableViewCell: UITableViewCell {
    
    @IBOutlet weak private var publishers: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configurePublishersTableViewCell(_ publishers: [String]) {
        self.backgroundColor = ColorUI.background
        self.publishers?.textColor = ColorUI.text
        self.publishers?.text = publishers
            .map{ "\u{2022} " + $0 }
            .joined(separator: "\n \n")
    }
}
