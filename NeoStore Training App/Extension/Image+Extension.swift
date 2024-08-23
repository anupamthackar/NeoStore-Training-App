//
//  Image Extension.swift
//  NeoStore Training App
//
//  Created by Neosoft on 30/07/24.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func loadImage(from url: String) {
        guard let url = URL(string: url) else { return }
        self.kf.setImage(with: url)
    }
}
