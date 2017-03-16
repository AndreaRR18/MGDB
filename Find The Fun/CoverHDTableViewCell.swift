import UIKit

final class CoverHDTableViewCell: UITableViewCell, XIBConstructible {
    
    @IBOutlet weak private var coverHQ: UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static var cellIdentifier: String {
        return "CoverHDTableViewCell"
    }
    
    func configureCoverHDTableViewCell() {
        self.backgroundColor = UIColor.clear
        coverHQ?.image = #imageLiteral(resourceName: "emptyBackground")
    }
}
