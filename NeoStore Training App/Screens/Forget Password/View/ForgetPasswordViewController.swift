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
    
    override func viewDidLoad() {
        SetImage()
    }
    
 
    
    @IBAction func sendPassworkButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
        navigationController?.pushViewController(loginVC!, animated: true)
    }
    
    func SetImage(){
        emailTextField.setIcon(_ImageLiteralType(imageLiteralResourceName: "email_icon"), placeholderName: "Email")
    }
    
}
