//
//  RegisterViewController.swift
//  NeoStore Training App
//
//  Created by Neosoft on 18/07/24.
//

import UIKit

class RegisterViewController: UIViewController {
    
    //MARK: Register Outlet
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmpasswordTextField: UITextField!
    @IBOutlet weak var femaleOptionBtn: UIButton!
    @IBOutlet weak var maleOptionBtn: UIButton!
    @IBOutlet weak var phonenumberTextField: UITextField!
    @IBOutlet weak var termsButton: UIButton!
    
    override func viewDidLoad() {
        ImageSetRegisterTextField()
        updateGenderButtons()
        updateTermsButton()
    }
    //MARK: Gender & T&C
    var selectedGender = "M"
    var isTermsAccepted: Bool = false
    
    let apiManagere = APIManager.shared
    let registerViewModel = RegisterViewModel()

    func registerUser() {
        guard let firstName = firstnameTextField.text, !firstName.isEmpty,
              let lastName = lastnameTextField.text, !lastName.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let confirmPassword = confirmpasswordTextField.text, !confirmPassword.isEmpty,
              let phoneNo = phonenumberTextField.text, !phoneNo.isEmpty,
              password == confirmPassword,
              isTermsAccepted
        else {
//            print("field missing")
            self.showAlert(message: "All Fields are required")
            return
        }
        
        let registrationData = RegistrationRequest(firstName: firstName,
                                               lastName: lastName,
                                               email: email,
                                               password: password,
                                               confirmPassword: confirmPassword,
                                               gender: selectedGender,
                                               phoneNo: phoneNo)
        
        registerViewModel.registerUser(with: registrationData) { [weak self] result in
            switch result {
            case .success(let message):
                    self?.showAlert(message: "Registration successful: \(message)", completion: {
                        self!.NavigateToLogin()
                    })
                case .failure(let error):
                    self!.showAlert(message: "Registration failed: \(error.localizedDescription)")
                    }
            }
    }
    
    //MARK: Register Action
    @IBAction func registerButtonTapped(_ sender: Any) {
        registerUser() 
    }
    
    @IBAction func maleOptionBtn(_ sender: Any) {
        selectedGender = "M"
        updateGenderButtons()
    }
    
    @IBAction func femaleOptionBtn(_ sender: Any) {
        selectedGender = "F"
        updateGenderButtons()
    }
    
    @IBAction func termsButtonTapped(_ sender: Any) {
        isTermsAccepted.toggle()
        updateTermsButton()
        
    }
    //MARK: Action Methods
    func updateTermsButton() {
        let imageName = isTermsAccepted ?  "checkmark.square.fill" : "square"
        let image = UIImage(systemName: imageName)?.withRenderingMode(.alwaysTemplate)
        termsButton.setImage(image, for: .normal)
        termsButton.tintColor = .white
        
    }
    
    func updateGenderButtons() {
        maleOptionBtn.setImage(UIImage(systemName: selectedGender == "M" ? "circle.fill" : "circle"), for: .normal)
        femaleOptionBtn.setImage(UIImage(systemName: selectedGender == "F" ? "circle.fill" : "circle"), for: .normal)
        
    }
    
    func ImageSetRegisterTextField(){
        firstnameTextField.setIcon(_ImageLiteralType(imageLiteralResourceName: "username_icon"), placeholderName: "First Name")
        lastnameTextField.setIcon(_ImageLiteralType(imageLiteralResourceName: "username_icon"), placeholderName: "Last Name")
        emailTextField.setIcon(_ImageLiteralType(imageLiteralResourceName: "email_icon"), placeholderName: "Email")
        passwordTextField.setIcon(_ImageLiteralType(imageLiteralResourceName: "cpassword_icon"), placeholderName: "Password")
        confirmpasswordTextField.setIcon(_ImageLiteralType(imageLiteralResourceName: "password_icon"), placeholderName: "Confirm Password")
        phonenumberTextField.setIcon(_ImageLiteralType(imageLiteralResourceName: "cellphone_icon"), placeholderName: "Phone Number")
    }
    
    func NavigateToLogin(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
            navigationController?.pushViewController(loginVC, animated: true)
        }
    }
}

