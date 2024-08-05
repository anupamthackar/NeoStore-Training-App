//
//  EnterQuantityViewController.swift
//  NeoStore Training App
//
//  Created by Neosoft on 02/08/24.
//

import UIKit

class EnterQuantityViewController: UIViewController {
    var productNames: String?
    var productImages: String?
    
    @IBAction func afterEnterSubmitBtnAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBOutlet weak var enterQuantity: UITextField!
    @IBOutlet weak var popupbackView: UIView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backButtonTitle = ""
        // Do any additional setup after loading the view.
        self.productName.text = productNames
        self.productImage.loadImage(from: productImages ?? "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        popupbackView.layer.cornerRadius = 10
    }
}
