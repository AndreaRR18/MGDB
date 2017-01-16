import UIKit

class CompanyTableViewCell: UITableViewCell {

    @IBOutlet weak var company: UILabel?
    
    static var companyTableViewCellIdentifier: String { return "CompanyTableViewCell" }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
