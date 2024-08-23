import UIKit

class ProductDetailsViewController: UIViewController {
    
    var prodID: Int!
    var prodCategory: String!
    
    @IBOutlet weak var productRateBtn: UIButton!
    @IBOutlet weak var productBuyNowBtn: UIButton!
    @IBOutlet weak var productDescription: UITextView!
    @IBOutlet weak var productThirdImage: UIImageView!
    @IBOutlet weak var productSecondImage: UIImageView!
    @IBOutlet weak var productFirstImage: UIImageView!
    @IBOutlet weak var productShareBtn: UIImageView!
    @IBOutlet weak var productMainImage: UIImageView!
    @IBOutlet weak var productCost: UILabel!
    @IBOutlet weak var productProducer: UILabel!
    @IBOutlet weak var productCategory: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet var starRatings: [UIImageView]!
    @IBOutlet weak var fourthViewForCurv: UIView!
    @IBOutlet weak var fifthViewForCurv: UIView!
    @IBOutlet weak var firstViewForCurve: UIView!
    
    let addToCartVM = addToCartViewModel()
    var productDetailsViewModel = ProductListDetailsVM()
    var productListTVCell = ProductListingTableViewCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDidLoadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.backButtonTitle = Texts.EmptyString
        fifthViewForCurv.layer.cornerRadius = 10
        fourthViewForCurv.layer.cornerRadius = 10
        firstViewForCurve.layer.cornerRadius = 10
    }
    
    func viewDidLoadData() {
        // Create the Home button
        let homeButton = UIBarButtonItem(image: UIImage(systemName: Images.houseFill), style: .plain, target: self, action: #selector(homeButtonTapped))
        
        // Create the My Cart button
        let cartButton = UIBarButtonItem(image: UIImage(systemName: Images.cartFill), style: .plain, target: self, action: #selector(cartButtonTapped))
        
        // Create the Search button
        //         let searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: nil)
        
        // Set the buttons on the right side of the navigation bar
        
        navigationItem.rightBarButtonItems = [homeButton, cartButton]
        
        self.navigationController?.navigationItem.backButtonDisplayMode = .minimal
        
        let req = ProductListDetailsRequest(productId: self.prodID)
        
        self.productDetailsViewModel.fatchProductsDetails(request: req){
            error in
            if let error = error {
                print( Texts.Error + "\(error)")
            } else {
                DispatchQueue.main.async {
                    let data = self.productDetailsViewModel.productsDetails?.data
                    self.productName.text = data?.name
                    self.productCategory.text = self.prodCategory
                    self.productProducer.text = Texts.FutureFurnitureCenter
                    self.productCost.text = "₹\(data?.cost ?? 0)"
                    self.productMainImage.loadImage(from: data?.productImages?.first?.image ?? Texts.EmptyString)
                    self.productFirstImage.loadImage(from: data?.productImages?.first?.image ?? Texts.EmptyString)
                    self.productSecondImage.loadImage(from: data?.productImages?.first?.image ?? Texts.EmptyString)
                    self.productThirdImage.loadImage(from: data?.productImages?.first?.image ?? Texts.EmptyString)
                    //self.productListTVCell.setRating(rating: data?.rating)
                    self.setRatings(rating: Int(data?.rating ?? 0))
                    self.productDescription.text = data?.description
                    self.navigationItem.title = data?.name
                }
            }
        }
    }
    
    @IBAction func RateActionBtn(_ sender: Any) {
        if let ratingPopUpVC = storyboard?.instantiateViewController(withIdentifier: Identifier.RatingPopUpViewController) as? RatingPopUpViewController {
            ratingPopUpVC.productNameRate = self.productDetailsViewModel.productsDetails?.data?.name
            ratingPopUpVC.productImageRate = self.productDetailsViewModel.productsDetails?.data?.productImages?.first?.image
            ratingPopUpVC.productId = self.productDetailsViewModel.productsDetails?.data?.id
            
//            self.navigationController?.pushViewController(ratingPopUpVC, animated: true)
            ratingPopUpVC.modalTransitionStyle = .crossDissolve
            ratingPopUpVC.modalPresentationStyle = .custom
            navigationController?.present(ratingPopUpVC, animated: true)
        }
    }
    
    @IBAction func BuyNowActionBtn(_ sender: Any) {
        if let enterQuantityVC = storyboard?.instantiateViewController(withIdentifier: Identifier.EnterQuantityViewController) as? EnterQuantityViewController {
            
            //product name, product image, and productId
            enterQuantityVC.productImages = self.productDetailsViewModel.productsDetails?.data?.productImages?.first?.image
            enterQuantityVC.productNames = self.productDetailsViewModel.productsDetails?.data?.name
            enterQuantityVC.productId = self.productDetailsViewModel.productsDetails?.data?.id ?? 0
            //            self.navigationController?.pushViewController(enterQuantityVC, animated: true)
            enterQuantityVC.modalTransitionStyle = .crossDissolve
            enterQuantityVC.modalPresentationStyle = .custom
            //self.navigationController?.pushViewController(enterQuantityVC, animated: true)
            navigationController?.present(enterQuantityVC, animated: true)
        }
    }
    
    @objc func homeButtonTapped() {
        // Navigate to HomeViewController
        if let homeVC = storyboard?.instantiateViewController(withIdentifier: Identifier.HomeViewController) as? HomeViewController {
            navigationController?.pushViewController(homeVC, animated: true)
        }
    }
    
    @objc func cartButtonTapped() {
        // Navigate to MyCartViewController
        if let cartVC = storyboard?.instantiateViewController(withIdentifier: Identifier.MyCartViewController) as? MyCartViewController {
            navigationController?.pushViewController(cartVC, animated: true)
        }
    }
    
    func setRatings(rating: Int) {
        let filledStarImage = UIImage(named: Images.starCheck) // Ensure these images are in your asset catalog
        let emptyStarImage = UIImage(named: Images.starUnchek)
        
        for (index, imageViews) in starRatings.enumerated() {
            if index < rating {
                imageViews.image = filledStarImage
            } else {
                imageViews.image = emptyStarImage
            }
        }
    }
}
