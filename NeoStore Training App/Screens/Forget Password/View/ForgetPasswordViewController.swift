import UIKit
import Foundation

class ForgetPasswordViewController: UIViewController {
    
    @IBOutlet weak var sendPasswordBtn: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    
    let viewModel =  ForgetPasswordViewModel()
    override func viewDidLoad() {
        SetImage()
        
        viewModel.forgetPasswordStatus = { [weak self] status in
            self?.HandlerStatus(status)
        }
    }
    
    @IBAction func sendPassworkButton(_ sender: Any) {
        guard let email = emailTextField.text, !email.isEmpty else {return}
        
        viewModel.forgetPassword(email: email)
    }
    
    func HandlerStatus(_ status: DataBinding<ForgetPasswordResponse> ){
        switch status{
        case .loading:
            print("Loading...")
        case .success(let result):
            print("Forget passwor: \(result.userMassage)")
            
        case .failure(let error):
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func SetImage(){
        emailTextField.setIcon(_ImageLiteralType(imageLiteralResourceName: Images.emailIcon), placeholderName: PlaceholderText.Email)
        emailTextField.addDoneButtonOnKeyboard()
    }
    
    func navigateToLogin(){
        let loginVC = storyboard?.instantiateViewController(withIdentifier: Identifier.LoginViewController) as? LoginViewController
        navigationController?.pushViewController(loginVC!, animated: true)
    }
}
