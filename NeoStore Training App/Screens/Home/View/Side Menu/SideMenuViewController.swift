//
//  SideMenuViewController.swift
//  NeoStore Training App
//
//  Created by Neosoft on 29/07/24.
//

import UIKit

protocol SideMenuViewControllerDelegate: AnyObject {
    func hideHamburgerMenu()
}

class SideMenuViewController: UIViewController {
    
    var delegate: SideMenuViewControllerDelegate?
    
    // Side Menu Outlet
    @IBOutlet weak var mainBackgroundView: UIView!
    @IBOutlet weak var UserImage: UIImageView!
    @IBOutlet weak var UserEmail: UILabel!
    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var SideMenuTableView: UITableView!
    
    //Table View Data
    let arrSideMenuLabel = ["MyCart","Tables","Sofas","Chairs","Cupboard","My Account","Store Location","My Order","Logout"]
    let arrSideMenuImg = ["shoppingcart_icon","tables_icon","sofa_icon","chair_icon","cupboard_icon","username_icon","storelocator_icon","myorders_icon","logout_icon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SideMenuTableView.register(UINib(nibName: "SideMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "SideMenuCell")
        
        mainBackgroundView.clipsToBounds = true
        
        UserImage.layer.cornerRadius = UserImage.frame.width/2
        
        setUserDetails()
    }
    
    func setUserDetails() {
        // Retrieve user details from UserDefaults
        if let firstName = UserDefaults.standard.string(forKey: "firstName"),
           let lastName = UserDefaults.standard.string(forKey: "lastName"),
           let email = UserDefaults.standard.string(forKey: "email") {
            UserName.text = "\(firstName) \(lastName)"
            UserEmail.text = email
        } 
    }

}

// Side Menu Extension
extension SideMenuViewController: UITableViewDelegate {}

extension SideMenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSideMenuLabel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SideMenuTableView.dequeueReusableCell(withIdentifier: "SideMenuCell") as? SideMenuTableViewCell
        cell?.img.image = UIImage(named: arrSideMenuImg[indexPath.row])
        cell?.label.text = arrSideMenuLabel[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
