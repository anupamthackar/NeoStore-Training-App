import UIKit

class ProductListingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productCost: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet var productRatingImage: [UIImageView]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCellPadding()
        
    }
    
    func setProductListCellData(product: Product) {
        print( Texts.ProductData + "\(product)")
    }
    
    private func setupCellPadding() {
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
    }
    
    func setRating(rating: Int) {
        let filledStarImage = UIImage(named: Images.starCheck) // Ensure these images are in your asset catalog
        let emptyStarImage = UIImage(named: Images.starUnchek)
        
        for (index, imageView) in productRatingImage.enumerated() {
            if index < rating {
                imageView.image = filledStarImage
            } else {
                imageView.image = emptyStarImage
            }
        }
    }
}
