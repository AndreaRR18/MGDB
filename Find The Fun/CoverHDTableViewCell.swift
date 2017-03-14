import UIKit

class CoverHDTableViewCell: UITableViewCell {

    @IBOutlet weak private var coverHQ: UIImageView?

    override func awakeFromNib() {
       
    super.awakeFromNib()
    
    }
    
    
    func configureCoverHDTableViewCell() {
        
        self.backgroundColor = UIColor.clear
        
        coverHQ?.image = #imageLiteral(resourceName: "emptyBackground")
    
    }

}
