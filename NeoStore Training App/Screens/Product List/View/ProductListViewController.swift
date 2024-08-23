import UIKit

class ProductListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    // Property to hold the category ID
    var categoryId: Int?
    private let viewModel = ProductListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Fetch products for the category
        configDependency()
        viewModelListners()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.backButtonTitle = Texts.EmptyString
        switch categoryId {
        case 1:
            navigationItem.title = Title.Tables
        case 2:
            navigationItem.title = Title.Chairs
        case 3:
            navigationItem.title = Title.Cupboards
        case 4:
            navigationItem.title = Title.Sofas
        default:
            return
        }
        
    }
    
    private func configDependency() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: NibName.ProductListingTableViewCell, bundle: nil), forCellReuseIdentifier: Identifier.ProductListingTableViewCell)
        
        // Create the Home button
        let homeButton = UIBarButtonItem(image: UIImage(systemName: Images.houseFill), style: .plain, target: self, action: #selector(homeButtonTapped))
        
        // Create the My Cart button
        let cartButton = UIBarButtonItem(image: UIImage(systemName: Images.cartFill), style: .plain, target: self, action: #selector(cartButtonTapped))
        
        // Set the buttons on the right side of the navigation bar
        navigationItem.rightBarButtonItems = [homeButton, cartButton]
        
        navigationItem.title = Title.Tables
    }
    
    private func viewModelListners() {
        
        let req = ProductRequest(
            product_category_id: self.categoryId ??  0,
            limit: 10, page: 1)
        
        self.viewModel.fetchProducts(
            req: req,
            categoryId: categoryId ?? 0,
            completion: { error in
                if let error = error {
                    print("Error: \(error)")
                } else {
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            })
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let productCount = self.viewModel.products?.data.count else {
            return 0
        }
        return productCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.ProductListingTableViewCell, for: indexPath) as! ProductListingTableViewCell
        
        guard let productData = self.viewModel.products?.data[indexPath.row] else {
            return UITableViewCell()
        }
        cell.setProductListCellData(product: productData)
        cell.productName.text = productData.name
        cell.productCost.text = "₹"+"\(productData.cost)"
        cell.productDescription.text = productData.description
        cell.productImage.loadImage(from: productData.productImages ?? Texts.EmptyString)
        cell.setRating(rating: Int(productData.rating))
        
        cell.layer.borderWidth = 3
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        //        cell.layoutMargins = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        cell.separatorInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let ProductDetailsVC = storyboard?.instantiateViewController(withIdentifier: Identifier.ProductDetailsViewController) as? ProductDetailsViewController {
            
            switch self.categoryId {
            case 1:
                ProductDetailsVC.prodCategory = Texts.CategoryTables
                navigationItem.title = Title.Tables
            case 2:
                ProductDetailsVC.prodCategory = Texts.CategoryChairs
                navigationItem.title = Title.Chairs
            case 3:
                ProductDetailsVC.prodCategory = Texts.CategorySofas
                navigationItem.title = Title.Sofas
            case 4:
                ProductDetailsVC.prodCategory = Texts.CategoryCupboard
                navigationItem.title = Title.Cupboards
            default:
                return
            }
            
            ProductDetailsVC.prodID = self.viewModel.products?.data[indexPath.row].id
            
            navigationController?.pushViewController(ProductDetailsVC, animated: true)
        }
    }
}
