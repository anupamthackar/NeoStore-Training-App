import UIKit

class AccountViewController: UIViewController {
    
    @IBOutlet weak var userMobileTextField: UITextField!
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userDOBTextField: UITextField!
    @IBOutlet weak var userLastNameTextField: UITextField!
    @IBOutlet weak var userFirstNameTextField: UITextField!
    @IBOutlet weak var userImage: UIImageView!
    
    private let viewModel = AccountViewModel()
    var isTermsAccepted: Bool = false
    var dataUser: AccountResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userImage.layer.cornerRadius = userImage.layer.frame.width / 2
        NotificationCenter.default.addObserver(self, selector: #selector(setProfileImage), name: .profileImageUpdated, object: nil)
        account()
        setProfileImage()
    }
    
    func account() {
        viewModel.fetchAccount { [weak self] response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self?.dataUser = data
                    self?.ImageSetAccountTextField()
                case .failure(let error):
                    self?.showAlert(message:AlertMessage.AccountFailed + error.localizedDescription)
                }
            }
        }
    }
    
    func ImageSetAccountTextField() {
        guard let userData = viewModel.accountResponse?.data?.user_data else { return }
        
        userFirstNameTextField.setIcon(_ImageLiteralType(imageLiteralResourceName: Images.usernameIcon), placeholderName: userData.first_name ?? Texts.EmptyString)
        userLastNameTextField.setIcon(_ImageLiteralType(imageLiteralResourceName: Images.usernameIcon), placeholderName: userData.last_name ?? Texts.EmptyString)
        userEmailTextField.setIcon(_ImageLiteralType(imageLiteralResourceName: Images.emailIcon), placeholderName: userData.email ?? Texts.EmptyString)
        userMobileTextField.setIcon(_ImageLiteralType(imageLiteralResourceName: Images.cellphoneIcon), placeholderName: "\(userData.phone_no ?? Texts.EmptyString )")
        userDOBTextField.setIcon(_ImageLiteralType(imageLiteralResourceName: Images.passwordIcon), placeholderName: userData.dob ?? Texts.EmptyString)
        
        // MARK: Done Keyboard
        userFirstNameTextField.addDoneButtonOnKeyboard()
        userLastNameTextField.addDoneButtonOnKeyboard()
        userEmailTextField.addDoneButtonOnKeyboard()
        userMobileTextField.addDoneButtonOnKeyboard()
        userDOBTextField.addDoneButtonOnKeyboard()
    }
    
    @objc func setProfileImage() {
        if let savedImageData = UserDefaults.standard.data(forKey: UserDefaultKey.profileImage),
           let savedImage = UIImage(data: savedImageData) {
            userImage.image = savedImage
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .profileImageUpdated, object: nil)
    }
    
    @IBAction func EditProfileActionBtn(_ sender: Any) {
        // Edit profile logic
        let editProfileVC = self.storyboard?.instantiateViewController(withIdentifier: Identifier.UpdateAccountViewController) as! UpdateAccountViewController
        self.navigationController?.pushViewController(editProfileVC, animated: true)
    }
    
    @IBAction func PasswordResetActionBtn(_ sender: Any) {
        // Reset password logic
        let resetPassVC = self.storyboard?.instantiateViewController(withIdentifier: Identifier.ResetPasswordViewController) as! ResetPasswordViewController
        self.navigationController?.pushViewController(resetPassVC, animated: true)
    }
}
