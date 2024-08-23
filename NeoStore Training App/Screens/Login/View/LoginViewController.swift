import UIKit
import Foundation

class LoginViewController: UIViewController {
    //Outlets:
    
    @IBOutlet weak var PasswordTextFeild: UITextField!
    @IBOutlet weak var UsernameTextFeild: UITextField!
    @IBOutlet weak var forgetPasswordBtn: UIButton!
    @IBOutlet weak var PlusNavigateRegisterBtn: UIButton!
    
    var loginViewModel = LoginViewModel()
    var errorMessage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ImageSet()
        KeyboardDoneLogin()
        UsernameTextFeild.text = "anupamthackar@gmail.com"
        PasswordTextFeild.text = "Anupam@12"
        //        checkForSavedToken()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationItem.hidesBackButton = true
    }
    
    @IBAction func ForgetPasswordBtnAction(_ sender: Any) {
        navigateToForgetPassword()
    }
    
    @IBAction func navigateToRegisterActionBtn(_ sender: Any) {
        navigateToRegister()
    }
    
    @IBAction func loginBtnTapped(_ sender: Any) {
        guard let username = UsernameTextFeild.text, !username.isEmpty,
              let password = PasswordTextFeild.text, !password.isEmpty else {
            return
        }
        
        let loginRequest = LoginRequest(email: username, password: password)
        //        loginViewModel.loginUser(with: loginRequest, completion: {_ in })
        
        loginViewModel.loginUser(with: loginRequest){ [weak self] result in
            switch result {
            case .success(_):
                self?.showAlert(message: AlertMessage.LoginSuccessful, completion: {
                    self?.navigateToHome()
                    UserDefaults.standard.setValue(self?.PasswordTextFeild.text, forKey: UserDefaultKey.password)
                })
            case .failure(let error):
                self?.showAlert(message: AlertMessage.LoginFailed + error.localizedDescription)
            }
        }
    }

    func ImageSet() {
        UsernameTextFeild.setIcon(_ImageLiteralType(imageLiteralResourceName: Images.usernameIcon), placeholderName: PlaceholderText.UserName)
        PasswordTextFeild.setIcon(_ImageLiteralType(imageLiteralResourceName: Images.passwordIcon), placeholderName: PlaceholderText.Password)
    }
    
    func KeyboardDoneLogin(){
        UsernameTextFeild.addDoneButtonOnKeyboard()
        PasswordTextFeild.addDoneButtonOnKeyboard()
    }
    
    func navigateToHome() {
        let HomeVC = storyboard?.instantiateViewController(withIdentifier: Identifier.HomeViewController) as? HomeViewController
        self.navigationController?.pushViewController(HomeVC!, animated: true)
    }
    
    func navigateToForgetPassword(){
        let forgetPasswordVC = storyboard?.instantiateViewController(withIdentifier: Identifier.ForgetPasswordViewController) as? ForgetPasswordViewController
        self.navigationController?.pushViewController(forgetPasswordVC!, animated: true)
    }
    
    func navigateToRegister(){
        let RegisterVC = storyboard?.instantiateViewController(withIdentifier: Identifier.RegisterViewController) as? RegisterViewController
        self.navigationController?.pushViewController(RegisterVC!, animated: true)
    }
}
