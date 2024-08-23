import UIKit

protocol SideMenuViewControllerDelegate: AnyObject {
    func hideHamburgerMenu()
}

class SideMenuViewController: UIViewController {
    let listCartVM = ListCartViewModel()
    
    var delegate: SideMenuViewControllerDelegate?
    
    // Side Menu Outlets
    @IBOutlet weak var mainBackgroundView: UIView!
    @IBOutlet weak var UserImage: UIImageView!
    @IBOutlet weak var UserEmail: UILabel!
    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var SideMenuTableView: UITableView!
    
    // Table View Data
    let arrSideMenuLabel = Arrays.arrSideMenuLabel
    let arrSideMenuImg = Arrays.arrSideMenuImg
    
    var CartCount: Int? = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SideMenuTableView.register(UINib(nibName: NibName.SideMenuTableViewCell, bundle: nil), forCellReuseIdentifier: Identifier.SideMenuCell)
        
        mainBackgroundView.clipsToBounds = true
        UserImage.layer.cornerRadius = UserImage.frame.width/2
        
        setUserDetails()
        NotificationCenter.default.addObserver(self, selector: #selector(updateProfileImage), name: .profileImageUpdated, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SideMenuTableView.reloadData()
    }
    
    @objc func updateProfileImage() {
        if let savedImageData = UserDefaults.standard.data(forKey: UserDefaultKey.profileImage),
           let savedImage = UIImage(data: savedImageData) {
            UserImage.image = savedImage
        }
    }
    
    func setUserDetails() {
        // Retrieve user details from UserDefaults
        if let firstName = UserDefaults.standard.string(forKey: UserDefaultKey.firstName),
           let lastName = UserDefaults.standard.string(forKey: UserDefaultKey.lastName),
           let email = UserDefaults.standard.string(forKey: UserDefaultKey.email) {
            UserName.text = "\(firstName) \(lastName)"
            UserEmail.text = email
        }
        
        // Retrieve and set the profile image from UserDefaults
        if let savedImageData = UserDefaults.standard.data(forKey: UserDefaultKey.profileImage),
           let savedImage = UIImage(data: savedImageData) {
            UserImage.image = savedImage
        }
    }
    
    private func navigateToProductList(with categoryId: Int) {
        if let productListVC = self.storyboard?.instantiateViewController(withIdentifier: Identifier.ProductListViewController) as? ProductListViewController {
            productListVC.categoryId = categoryId
            navigationController?.pushViewController(productListVC, animated: true)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .profileImageUpdated, object: nil)
    }
}

// Side Menu Extensions
extension SideMenuViewController: UITableViewDelegate {}

extension SideMenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSideMenuLabel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SideMenuTableView.dequeueReusableCell(withIdentifier: Identifier.SideMenuCell) as? SideMenuTableViewCell
        cell?.img.image = UIImage(named: arrSideMenuImg[indexPath.row])
        cell?.label.text = arrSideMenuLabel[indexPath.row]
        
        if indexPath.row == 0 {
            let totalCount = UserDefaults.standard.integer(forKey: UserDefaultKey.totalCarts)
            cell?.cartCountLabel.text = "\(totalCount)"
            cell?.cartCountView.isHidden = totalCount == 0
        } else {
            cell?.cartCountView.isHidden = true
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let myCartVC = self.storyboard?.instantiateViewController(withIdentifier: Identifier.MyCartViewController ) as! MyCartViewController
            navigationController?.pushViewController(myCartVC, animated: true)
        case 1:
            navigateToProductList(with: 1)
        case 2:
            navigateToProductList(with: 4)
        case 3:
            navigateToProductList(with: 2)
        case 4:
            navigateToProductList(with: 3)
        case 5:
            let accountVC = self.storyboard?.instantiateViewController(withIdentifier: Identifier.AccountViewController) as! AccountViewController
            navigationController?.pushViewController(accountVC, animated: true)
        case 6:
            let storeVC = self.storyboard?.instantiateViewController(withIdentifier: Identifier.StoreLocationViewController) as! StoreLocationViewController
            navigationController?.pushViewController(storeVC, animated: true)
        case 7:
            let orderListVC = self.storyboard?.instantiateViewController(withIdentifier: Identifier.OrderListViewController) as! OrderListViewController
            navigationController?.pushViewController(orderListVC, animated: true)
        case 8:
            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                sceneDelegate.logout()
            }
        default:
            return
        }
    }
}
