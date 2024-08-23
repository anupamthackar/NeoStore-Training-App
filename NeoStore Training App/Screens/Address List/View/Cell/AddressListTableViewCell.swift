import UIKit

class AddressListTableViewCell: UITableViewCell {
    
//    var isSelectedAddress: Bool = false
    
    @IBOutlet weak var addressBackView: UIView!
    @IBOutlet weak var deleteAddressBtn: UIButton!
    @IBOutlet weak var AddressTextView: UITextView!
    @IBOutlet weak var AddressNameLabel: UILabel!
    @IBOutlet weak var AddressSelectBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        self.addressBackView.layer.cornerRadius = 10
        self.addressBackView.layer.borderWidth = 1
        if let greycol = UIColor(named: "gray"){
            self.addressBackView.layer.borderColor = greycol.cgColor
        }
    }
    
//    @IBAction func addressActionBtn(_ sender: Any) {
//        AddressSelectBtn.setImage(UIImage(systemName: isSelectedAddress == true ? "circle" : "circle.inset.filled"), for: .normal)
//    }
}
