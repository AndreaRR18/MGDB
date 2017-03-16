import UIKit

class CompanyTableViewCell: UITableViewCell {
    
    @IBOutlet weak private var company: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(
            selected,
            animated: animated)
    }
    
    func configureCompanyTableViewCell(_ company: String) {
        self.backgroundColor = ColorUI.background
        self.company?.textColor = ColorUI.text
        self.company?.text = company
    }
}
