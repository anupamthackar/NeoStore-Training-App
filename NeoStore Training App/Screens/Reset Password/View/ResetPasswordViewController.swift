import UIKit

class ResetPasswordViewController: UIViewController {
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var oldPasswordTextField: UITextField!
    
    private let viewModel = ResetPasswordViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ImageSetResetPasswordTextField()
    }
    
    func postResetPassword() {
        let pass = UserDefaults.standard.string(forKey: UserDefaultKey.password)
        
        guard let oldPass = oldPasswordTextField.text, !oldPass.isEmpty,
              let newPass = newPasswordTextField.text, !newPass.isEmpty,
              let conPass = confirmPasswordTextField.text, !conPass.isEmpty,
              newPass == conPass,
              oldPass == pass  else {
            showAlert(message: AlertMessage.AllFieldsAreRequired)
            return
        }
        
        let resetPasswordRequest = ResetPasswordRequest(
            old_password: oldPass,
            password: newPass,
            confirm_password: conPass)
        
        viewModel.postResetPassword(with: resetPasswordRequest) { response in
            switch response {
            case .success(let message):
                self.showAlert(message: AlertMessage.UpdateSuccessfully + "\(message)")
            case .failure(let error):
                self.showAlert(message: AlertMessage.UpdateFailed + error.localizedDescription)
            }
        }
    }
    
    func ImageSetResetPasswordTextField() {
        
        oldPasswordTextField.setIcon(_ImageLiteralType(imageLiteralResourceName: Images.cpasswordIcon), placeholderName: PlaceholderText.OldPassword)
        newPasswordTextField.setIcon(_ImageLiteralType(imageLiteralResourceName: Images.passwordIcon), placeholderName: PlaceholderText.NewPassword)
        confirmPasswordTextField.setIcon(_ImageLiteralType(imageLiteralResourceName: Images.passwordIcon), placeholderName: PlaceholderText.ConfirmPassword)
        
        oldPasswordTextField.addDoneButtonOnKeyboard()
        newPasswordTextField.addDoneButtonOnKeyboard()
        confirmPasswordTextField.addDoneButtonOnKeyboard()
    }
    
    @IBAction func resetPasswordActionBtn(_ sender: Any) {
        postResetPassword()
        self.navigationController?.popViewController(animated: true)
    }
}
