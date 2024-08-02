//
//  ProductDetailsViewController.swift
//  NeoStore Training App
//
//  Created by Neosoft on 01/08/24.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    
    @IBOutlet weak var productRateBtn: UIButton!
    @IBOutlet weak var productBuyNowBtn: UIButton!
    @IBOutlet weak var productDescription: UITextView!
    @IBOutlet weak var productThirdImage: UIImageView!
    @IBOutlet weak var productSecondImage: UIImageView!
    @IBOutlet weak var productFirstImage: UIImageView!
    @IBOutlet weak var productShareBtn: UIImageView!
    @IBOutlet weak var productMainImage: UIImageView!
    @IBOutlet weak var productCost: UILabel!
    @IBOutlet weak var productProducer: UILabel!
    @IBOutlet weak var productCategory: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet var starRatings: [UIImage]!
    
    private let productDetailsViewModel = ProductListDetailsViewModel()
    
    var prodID: Int!
    var prodCategory: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        let req = ProductListDetailsRequest(productId: self.prodID)
        self.productDetailsViewModel.fatchProductsDetails(request: req){
            error in
            if let error = error {
                print("Error: \(error)")
            } else {
                DispatchQueue.main.async {
                    let data = self.productDetailsViewModel.productsDetails?.data
                    self.productName.text = data?.name
                    self.productCategory.text = self.prodCategory
                    self.productProducer.text = "Future Furniture Center"
                    self.productCost.text = "$ \(data?.cost ?? 0)"
                    self.productMainImage.loadImage(from: data?.productImages?.first?.image ?? "")
                    self.productFirstImage.loadImage(from: data?.productImages?.first?.image ?? "")
                    self.productSecondImage.loadImage(from: data?.productImages?.first?.image ?? "")
                    self.productThirdImage.loadImage(from: data?.productImages?.first?.image ?? "")
                }
            }
        }
    }
    func setRating(rating: Int) {
        let filledStarImage = UIImage(named: "star_check") // Ensure these images are in your asset catalog
        let emptyStarImage = UIImage(named: "star_unchek")
        
        for (index, imageViews) in starRating.enumerated() {
            if index < rating {
                self.starRating.image = filledStarImage
            } else {
                UIImage.image = emptyStarImage
            }
        }
        
    }
}
