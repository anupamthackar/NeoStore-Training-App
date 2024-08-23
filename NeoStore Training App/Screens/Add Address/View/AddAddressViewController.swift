import UIKit

protocol AddAddressDelegate: AnyObject {
    func didAddAddress(_ address: Address)
}

class AddAddressViewController: UIViewController {
    
    @IBOutlet weak var mainAddressTextField: UITextField!
    @IBOutlet weak var townTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    
    weak var delegate: AddAddressDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveAddressActionBtn(_ sender: Any) {
        guard let mainAddress = mainAddressTextField.text, !mainAddress.isEmpty,
              let town = townTextField.text, !town.isEmpty,
              let city = cityTextField.text, !city.isEmpty,
              let state = stateTextField.text, !state.isEmpty,
              let zipCode = zipCodeTextField.text, !zipCode.isEmpty,
              let country = countryTextField.text, !country.isEmpty
        else {
            self.showAlert(message: AlertMessage.AllFieldsAreRequired)
            return
        }
        let newAddress = Address(mainAddress: mainAddress, town: town, city: city, state: state, zipcode: zipCode, country: country)
        
        // Notify delegate
        delegate?.didAddAddress(newAddress)
        
        // Save the new address to UserDefaults
        saveAddressToUserDefaults(newAddress)
        
        // Navigate back to AddressListViewController
        self.navigationController?.popViewController(animated: true)
    }
    
    func saveAddressToUserDefaults(_ address: Address) {
        // Retrieve existing addresses
        var savedAddresses = [Address]()
        if let savedAddressesData = UserDefaults.standard.data(forKey: UserDefaultKey.savedAddresses),
           let loadedAddresses = try? JSONDecoder().decode([Address].self, from: savedAddressesData) {
            savedAddresses = loadedAddresses
        }
        
        // Append the new address
        savedAddresses.append(address)
        
        // Save the updated array to UserDefaults
        if let updatedAddressesData = try? JSONEncoder().encode(savedAddresses) {
            UserDefaults.standard.set(updatedAddressesData, forKey: UserDefaultKey.savedAddresses)
        }
    }
}
