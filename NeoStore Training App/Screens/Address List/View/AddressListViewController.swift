import UIKit

class AddressListViewController: UIViewController, AddAddressDelegate {
    
    @IBOutlet weak var addressListTableView: UITableView!
    
    private var selectedAddressIndex: Int?
    
    private var viewModel = AddressListViewModel()
    private var addresses = [Address]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configAddressList()
        loadAddressesFromUserDefaults()
    }
    
    func configAddressList() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: Images.plus), style: .plain, target: self, action: #selector(navigateToAddAddress))
        addressListTableView.delegate = self
        addressListTableView.dataSource = self
        addressListTableView.register(UINib(nibName: NibName.AddressListTableViewCell, bundle: nil), forCellReuseIdentifier: Identifier.AddressListTableViewCell)
        
        navigationItem.title = Title.AddressList
    }
    
    @objc func navigateToAddAddress() {
        let addAddressVC = self.storyboard?.instantiateViewController(identifier: Identifier.AddAddressViewController) as! AddAddressViewController
        addAddressVC.delegate = self
        navigationController?.pushViewController(addAddressVC, animated: true)
    }
    
    func loadAddressesFromUserDefaults() {
        if let savedAddressesData = UserDefaults.standard.data(forKey: UserDefaultKey.savedAddresses),
           let loadedAddresses = try? JSONDecoder().decode([Address].self, from: savedAddressesData) {
            addresses = loadedAddresses
        }
        addressListTableView.reloadData()
    }
    
    func didAddAddress(_ address: Address) {
        addresses.append(address)
        saveAddressesToUserDefaults()
        addressListTableView.reloadData()
    }
    
    func saveAddressesToUserDefaults() {
        if let updatedAddressesData = try? JSONEncoder().encode(addresses) {
            UserDefaults.standard.set(updatedAddressesData, forKey: UserDefaultKey.savedAddresses)
        }
    }
    
    @IBAction func placeOrderActionBtn(_ sender: Any) {
        // Example of placing an order with the first address (you might want to select an address first)
        guard let selectedAddress = addresses.first else {
            showAlert(message: AlertMessage.NoAddressSelected)
            return
        }
        
        let addressRequest = AddressRequest(
            address: "\(selectedAddress.mainAddress), \(selectedAddress.town), \(selectedAddress.city), \(selectedAddress.state), \(selectedAddress.zipcode), \(selectedAddress.country)"
        )
        
        viewModel.AddressPost(with: addressRequest) { result in
            switch result {
            case .success(let response):
                self.showAlert(message: response.user_msg, completion: {
                    if let homeVC = self.storyboard?.instantiateViewController(withIdentifier: Identifier.HomeViewController) as? HomeViewController {
                        self.navigationController?.pushViewController(homeVC, animated: true)
                    }
                })
                
            case .failure(let error):
                self.showAlert(message: error.localizedDescription)
            }
        }
    }
}

extension AddressListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addresses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.AddressListTableViewCell, for: indexPath) as! AddressListTableViewCell
        let address = addresses[indexPath.row]
        
        cell.AddressNameLabel.text = "\(address.mainAddress)"
        cell.AddressTextView.text = "\(address.town), \(address.city), \(address.state), \(address.zipcode), \(address.country)"
        cell.deleteAddressBtn.tag = indexPath.row
        cell.deleteAddressBtn.addTarget(self, action: #selector(deleteAddress(_:)), for: .touchUpInside)
        cell.AddressSelectBtn.tag = indexPath.row
        cell.AddressSelectBtn.setImage(UIImage(systemName: address.isSelected ? Images.circleInsetFilled : Images.circle), for: .normal)
        cell.AddressSelectBtn.addTarget(self, action: #selector(selectAddress(_:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func deleteAddress(_ sender: UIButton) {
        let index = sender.tag
        addresses.remove(at: index)
        saveAddressesToUserDefaults()
        addressListTableView.reloadData()
    }
    
    @objc func selectAddress(_ sender: UIButton) {
        let index = sender.tag
        
        if let previousIndex = selectedAddressIndex {
            if previousIndex != index {
                addresses[previousIndex].isSelected = false
            }
        }
        
        addresses[index].isSelected.toggle()
        selectedAddressIndex = addresses[index].isSelected ? index : nil
        addressListTableView.reloadData()
    }
}
