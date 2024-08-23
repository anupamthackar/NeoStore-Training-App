import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var HamburgerView: UIView!
    @IBOutlet weak var leadingConstraintsForHamburger: NSLayoutConstraint!
    @IBOutlet weak var ImageSliderCollectionView: UICollectionView!
    @IBOutlet weak var pageControler: UIPageControl!
    
    let ProductImages = Arrays.ProductImages
    var currentCellIndex = 0
    
    //    let sideMenuVC = SideMenuViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(UserDefaults.standard.string(forKey: UserDefaultKey.accessToken) ?? Texts.EmptyString)
        setupUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.backButtonTitle = Texts.EmptyString
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        hideHamburgerMenuView()
    }
    
    private func setupUI() {
        HamburgerView.isHidden = true
        
        ImageSliderCollectionView.delegate = self
        ImageSliderCollectionView.dataSource = self
        ImageSliderCollectionView.register(UINib(nibName: NibName.ImageSliderCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Identifier.ImageSliderCell)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: .menuIcon, style: .plain, target: self, action: #selector(hamburgerMenuAction))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .searchIcon, style: .plain, target: self, action: nil)
        navigationItem.title = Title.NeoStore
        
        pageControler.numberOfPages = ProductImages.count
        
        //        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapOnHamburgerBackView(_:)))
        //        view.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func hamburgerMenuAction() {
        if leadingConstraintsForHamburger.constant == -280 {
            HamburgerView.isHidden = false
            leadingConstraintsForHamburger.constant = 0
            UIView.animate(withDuration: 0.7) {
                self.view.layoutIfNeeded()
            }
        } else {
            hideHamburgerMenuView()
        }
    }
    
    @IBAction func tapOnHamburgerBackView(_ sender: Any) {
        hideHamburgerMenuView()
    }
    
    private func hideHamburgerMenuView() {
        HamburgerView.isHidden = true
        leadingConstraintsForHamburger.constant = -280
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
        }
    }
    
    
    @IBAction func TableNavAction(_ sender: Any) {
        navigateToProductList(with: 1)
    }
    
    @IBAction func ChairNavAction(_ sender: Any) {
        navigateToProductList(with: 2)
    }
    
    @IBAction func CupboardNavAction(_ sender: Any) {
        navigateToProductList(with: 3)
    }
    
    @IBAction func SofasNavAction(_ sender: Any) {
        navigateToProductList(with: 4)
    }
    
    private func navigateToProductList(with categoryId: Int) {
        if let productListVC = storyboard?.instantiateViewController(withIdentifier: Identifier.ProductListViewController) as? ProductListViewController {
            productListVC.categoryId = categoryId
            navigationController?.pushViewController(productListVC, animated: true)
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ProductImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = ImageSliderCollectionView.dequeueReusableCell(withReuseIdentifier: Identifier.ImageSliderCell, for: indexPath) as! ImageSliderCollectionViewCell
        cell.SliderImage.image = UIImage(named: ProductImages[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ImageSliderCollectionView.frame.width, height: ImageSliderCollectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.width
        currentCellIndex = Int(scrollView.contentOffset.x / pageWidth)
        pageControler.currentPage = currentCellIndex
//        print("Current page: \(currentCellIndex)")
    }
}
