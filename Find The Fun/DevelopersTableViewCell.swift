import UIKit

class DevelopersTableViewCell: UITableViewCell {

    @IBOutlet weak private var developers: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureDeveloperTableViewCell(_ developers: [String]) {
        self.backgroundColor = ColorUI.background
        self.developers?.textColor = ColorUI.text
        self.developers?.text = developers
            .map{ "\u{2022} " + $0 }
            .joined(separator: "\n \n")
    }
    
}
