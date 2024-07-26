//
//  ForgetPasswordViewController.swift
//  NeoStore Training App
//
//  Created by Neosoft on 24/07/24.
//

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
        emailTextField.setIcon(_ImageLiteralType(imageLiteralResourceName: "email_icon"), placeholderName: "Email")
        emailTextField.addDoneButtonOnKeyboard()
    }
    
    func navigateToLogin(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
        navigationController?.pushViewController(loginVC!, animated: true)
    }
}
