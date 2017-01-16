import UIKit

class NamePhotoTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnail: UIImageView?
    @IBOutlet weak var name: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
