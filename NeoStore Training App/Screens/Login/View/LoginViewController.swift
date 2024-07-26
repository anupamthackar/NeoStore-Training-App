//
//  LoginViewController.swift
//  NeoStore Training App
//
//  Created by Neosoft on 17/07/24.
//

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
        PasswordTextFeild.text = "Manojji@11"
        
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
            showAlert(message: "Login Successful!", completion: {
                self.navigateToHome()
            })
            return
        }
        
        let loginRequest = LoginRequest(email: username, password: password)
        loginViewModel.loginUser(with: loginRequest, completion: {_ in })
        
        loginViewModel.loginUser(with: loginRequest){ [weak self] result in
            switch result {
            case .success(_):
                self?.showAlert(message: "Login Successful", completion: {
                    self?.navigateToHome()
                })
            case .failure(let error):
                self?.showAlert(message: "Login Failed: \(error.localizedDescription)")
            }
        }
    }
    
    func ImageSet() {
        UsernameTextFeild.setIcon(_ImageLiteralType(imageLiteralResourceName: "username_icon"), placeholderName: "User Name")
        PasswordTextFeild.setIcon(_ImageLiteralType(imageLiteralResourceName: "password_icon"), placeholderName: "Password")
    }
    
    func KeyboardDoneLogin(){
        UsernameTextFeild.addDoneButtonOnKeyboard()
        PasswordTextFeild.addDoneButtonOnKeyboard()
    }
    
    func navigateToHome() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let HomeVC = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
        self.navigationController?.pushViewController(HomeVC!, animated: true)
    }
    
    func navigateToForgetPassword(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let forgetPasswordVC = storyboard.instantiateViewController(withIdentifier: "ForgetPasswordViewController") as? ForgetPasswordViewController
        self.navigationController?.pushViewController(forgetPasswordVC!, animated: true)
    }
    
    func navigateToRegister(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let RegisterVC = storyboard.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController
        self.navigationController?.pushViewController(RegisterVC!, animated: true)
    }
}
