import UIKit

class OrderDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var orderProductName: UILabel!
    @IBOutlet weak var orderProductCost: UILabel!
    @IBOutlet weak var orderProductQuantity: UILabel!
    @IBOutlet weak var orderProductCategory: UILabel!
    @IBOutlet weak var orderProductImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
