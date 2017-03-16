import UIKit

class RelatedInDescriptionTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(
            selected,
            animated: animated)
    }
    
    
    func configureRelatedInDescriptionTableViewCell() {
        self.backgroundColor = ColorUI.background
    }
}
