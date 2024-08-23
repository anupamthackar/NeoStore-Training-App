import UIKit

class MyCartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productCategoryLabel: UILabel!
    @IBOutlet weak var productCostLabel: UILabel!
    @IBOutlet weak var quantityViewBtn: UIButton!
    @IBOutlet weak var quantityLabel: UILabel!
    
    var quantityDidChange: ((Int) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        showQuantityDropdown()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func showQuantityDropdown() {
        let menuItems: [UIAction] = (1...5).map { i in
            UIAction(title: "\(i)", handler: { [weak self] _ in
                self?.quantityLabel.text = "\(i)"
                self?.quantityDidChange?(i)
            })
        }
        let menu = UIMenu(title: "Select Quantity", children: menuItems)
        quantityViewBtn.menu = menu
        quantityViewBtn.showsMenuAsPrimaryAction = true
    }
}

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while let responder = parentResponder {
            parentResponder = responder.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
