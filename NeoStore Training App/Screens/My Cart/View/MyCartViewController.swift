import UIKit
import Foundation

class MyCartViewController: UIViewController {
    
    
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var totalCostLabel: UILabel!
    @IBOutlet weak var orderNowButton: UIButton!
    
    private var cartItems: [CartItem] = []
    
    private var listCartViewModel = ListCartViewModel()
    private var editCartViewModel = EditCartViewModel()
    private var deleteCartViewModel = DeleteCartViewModel()
    private let sideMenuTV = SideMenuViewController().SideMenuTableView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            
            self.fetchCartItems()
            self.cartTableView.reloadData()
            
        }
    }
    
    private func setupTableView() {
        cartTableView.delegate = self
        cartTableView.dataSource = self
        cartTableView.register(UINib(nibName: NibName.MyCartTableViewCell, bundle: nil), forCellReuseIdentifier: NibName.MyCartTableViewCell)
    }
    
    private func fetchCartItems() {
        listCartViewModel.fetchCartItems { [weak self] result in
            switch result {
            case .success(let response):
                self?.cartItems = response.data!
                self?.updateTotalCost()
                self?.cartTableView.reloadData()
                self?.sideMenuTV?.reloadData()
            case .failure(let error):
                print(Texts.FailedToFetchCartItems + error.localizedDescription)
            }
        }
    }
    
    private func updateTotalCost() {
        let totalCost = cartItems.reduce(0) { $0 + Int($1.product.cost) * $1.quantity }
        totalCostLabel.text = Texts.Total  + "\(totalCost)"
    }
    
    @IBAction func orderNowTapped(_ sender: UIButton) {
        let addressListCV = self.storyboard?.instantiateViewController(identifier: Identifier.AddressListViewController) as! AddressListViewController
        self.navigationController?.pushViewController(addressListCV, animated: true)
        self.sideMenuTV?.reloadData()
    }
}

extension MyCartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if cartItems.isEmpty {
            return UITableViewCell()
        }
        let cell = cartTableView.dequeueReusableCell(withIdentifier: Identifier.MyCartTableViewCell, for: indexPath) as! MyCartTableViewCell
        let cartItem = cartItems[indexPath.row]
        
        cell.productNameLabel.text = cartItem.product.name
        cell.productCategoryLabel.text = cartItem.product.productCategory
        cell.productCostLabel.text = "₹\(cartItem.product.cost)"
        cell.quantityLabel.text = "\(cartItem.quantity)"
        cell.productImageView.loadImage(from: cartItem.product.productImages ?? Texts.EmptyString)
        cell.quantityDidChange = { [weak self] newQuantity in
            self?.editCartItem(at: indexPath.row, newQuantity: newQuantity)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteCartItem(at: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    private func editCartItem(at index: Int, newQuantity: Int) {
        let cartItem = cartItems[index]
        let request = EditCartRequest(productId: cartItem.product.id, quantity: newQuantity)
        
        editCartViewModel.editCart(with: request) { [weak self] result in
            switch result {
            case .success:
                self?.cartItems[index].quantity = newQuantity
                self?.updateTotalCost()
                self?.cartTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                self?.sideMenuTV?.reloadData()
            case .failure(let error):
                print(Texts.FailedToEditCartItem + error.localizedDescription)
            }
        }
    }
    
    private func deleteCartItem(at index: Int) {
        let cartItem = cartItems[index]
        let request = DeleteCartRequest(productId: cartItem.product.id)
        
        deleteCartViewModel.deleteCart(with: request) { [weak self] result in
            switch result {
            case .success:
                self?.cartItems.remove(at: index)
                self?.updateTotalCost()
                self?.cartTableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                self?.sideMenuTV?.reloadData()
            case .failure(let error):
                print(Texts.FailedToDeleteCartItem + error.localizedDescription)
            }
        }
    }
}
