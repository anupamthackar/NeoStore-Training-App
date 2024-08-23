import UIKit

class EnterQuantityViewController: UIViewController {
    let AddToCartVM = addToCartViewModel()
    
    var productNames: String?
    var productImages: String?
    var productId: Int = 0
    
    @IBOutlet weak var enterQuantity: UITextField!
    @IBOutlet weak var popupbackView: UIView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backButtonTitle = Texts.EmptyString
        enterQuantity.addDoneButtonOnKeyboard()
        configTheme()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        popupbackView.layer.cornerRadius = 10
    }
    
    private func configTheme() {
        self.productName.text = productNames
        self.productImage.loadImage(from: productImages ?? Texts.EmptyString)
    }
    
    func setUpFunction(){
        
        guard let productText = self.enterQuantity.text,
              let productQuantity = Int(productText) else { return }
        
        let addToCartRequest = AddToCartRequest(productId: self.productId, quantity: productQuantity)
        
        AddToCartVM.addToCartData(with: addToCartRequest) { result in
            switch result {
            case .success(let data):
                self.showAlert(message: AlertMessage.ProductAddedToCart + "\(data)", completion: {
                    //                    self.navigateToMyCart()
                })
            case .failure(let error):
                self.showAlert(message: AlertMessage.ProductfailedAddedToCartPleaseTryAgain + "\(error)", completion: {
                })
            }
        }
    }
    
    func navigateToProductDetail(){
        if let productDeatilVC = self.storyboard?.instantiateViewController(withIdentifier: Identifier.ProductDetailsViewController) as? ProductDetailsViewController{
            self.navigationController?.pushViewController(productDeatilVC, animated: true)
        }
    }
    func navigateToMyCart(){
        let MyCartVC = self.storyboard?.instantiateViewController(withIdentifier: Identifier.MyCartViewController) as! MyCartViewController
        self.navigationController?.pushViewController(MyCartVC, animated: true)
    }
    
    @IBAction func afterEnterSubmitBtnAction(_ sender: Any) {
        setUpFunction()
        dismiss(animated: true)
        
    }
    @objc func handleTap() {
        // Dismiss the view controller
        self.dismiss(animated: true, completion: nil)
    }
}
