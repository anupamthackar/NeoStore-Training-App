import UIKit

class StoreLocationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var storeAddressLabel: UILabel!
    @IBOutlet weak var StoreNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
