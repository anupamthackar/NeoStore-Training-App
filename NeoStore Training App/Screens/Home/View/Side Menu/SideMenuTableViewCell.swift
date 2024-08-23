import UIKit

class SideMenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var cartCountLabel: UILabel!
    @IBOutlet weak var cartCountView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        SetUpCart()
        // Configure the view for the selected state
    }
    
    func SetUpCart(){
        cartCountView.layer.cornerRadius = cartCountView.frame.size.width / 2
        cartCountView.clipsToBounds = true
    }
}
