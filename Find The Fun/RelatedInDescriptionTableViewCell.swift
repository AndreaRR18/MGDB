import UIKit

final class RelatedInDescriptionTableViewCell: UITableViewCell, XIBConstructible {
    
    static var cellIdentifier: String {
        return "RelatedInDescriptionTableViewCell"
    }

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
