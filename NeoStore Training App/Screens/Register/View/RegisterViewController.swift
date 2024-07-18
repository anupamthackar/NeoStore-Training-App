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
    @IBAction func femaleOptionBtn(_ sender: Any) {
    }
    @IBOutlet weak var maleOptionBtn: UIButton!
    @IBOutlet weak var phonenumberTextField: UITextField!
    @IBOutlet weak var termsConditionTextField: UIButton!
    
    let apiManagere = APIManager.shared
    
    //MARK: Register Action
    @IBAction func registerButtonTapped(_ sender: Any) {
        guard let firstName = firstnameTextField.text, !firstName.isEmpty,
              let lastName = lastnameTextField.text, !lastName.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let confirmPassword = confirmpasswordTextField.text, !confirmPassword.isEmpty,
              let phoneNo = phonenumberTextField.text, !phoneNo.isEmpty,
              password == confirmPassword
        else {
//            print("field missing")
            self.showAlert(message: "All Fields are required")
            return
        }
        
        let registerData = RegistrationRequest(firstName: firstName,
                                               lastName: lastName,
                                               email: email,
                                               password: password,
                                               confirmPassword: confirmPassword,
                                               gender: "M",
                                               phoneNo: phoneNo)

        
    }

    
    func NavigateToLogin(){
        
    }
}

