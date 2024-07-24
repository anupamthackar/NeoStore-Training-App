//
//  TextFieldExension.swift
//  NeoStore Training App
//
//  Created by Neosoft on 23/07/24.
//

import Foundation
import UIKit

extension UITextField {
    func setIcon (_ image: UIImage, placeholderName: String) {
        let iconView = UIImageView(frame: CGRect(x: 10, y: 5, width: 18, height: 20))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
        self.tintColor = UIColor.white
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1.0
        
        //MARK: Changing Placeholder Name and style
        let placeHolder = NSAttributedString(string: placeholderName, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white,
            .font: UIFont.boldSystemFont(ofSize: 18.0)])
        self.attributedPlaceholder = placeHolder
    }
}
