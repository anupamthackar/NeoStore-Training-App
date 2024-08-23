//
//  ShowAlertExtension.swift
//  NeoStore Training App
//
//  Created by Neosoft on 18/07/24.
//

import UIKit

extension UIViewController {
    
    func showAlert(message: String, completion: (() -> Void)? = nil){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        }
    )
        self.present(alert, animated: true,completion: nil)
    }
}

