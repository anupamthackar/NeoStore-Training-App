//
//  HomeViewController.swift
//  NeoStore Training App
//
//  Created by Neosoft on 24/07/24.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    //Images Outlet
    @IBOutlet weak var cupboardImage: UIImageView!
    @IBOutlet weak var chairImage: UIImageView!
    @IBOutlet weak var sofaImage: UIImageView!
    @IBOutlet weak var tableImage: UIImageView!
    
    //Collection View Outlet
    @IBOutlet weak var ImageSliderCollectionView: UICollectionView!

    var ProductImages = ["slider_img1","slider_img2","slider_img3","slider_img4"]
    
    var time: Timer?
    var currentcellIndex = 0
    
    override func viewDidLoad() {
        //Define delegate and datasourse
        ImageSliderCollectionView.delegate = self
        ImageSliderCollectionView.dataSource = self
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: .menuIcon, style: .plain, target: self , action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .searchIcon, style: .plain, target: self, action: nil)
        navigationItem.title = "NeoStore"
        navigationItem.titleView?.backgroundColor = .red
        
        time = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(slideTonext), userInfo: nil, repeats: true)
    }
    
    @objc func slideTonext(){
        if currentcellIndex < ProductImages.count - 1 {
            currentcellIndex += 1
        }
        else {
            currentcellIndex = 0
        }
        
        ImageSliderCollectionView.scrollToItem(at: IndexPath(item: currentcellIndex, section: 1) ,at: .right, animated: true)
        
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ImageSliderCollectionView.frame.width, height: ImageSliderCollectionView.frame.height)
    }
}

extension HomeViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ProductImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = ImageSliderCollectionView.dequeueReusableCell(withReuseIdentifier: "ImageSliderCell", for: indexPath) as! ImageSliderCollectionViewCell
        cell.MyImageSlider.image = UIImage(named: ProductImages[indexPath.row])
        return cell
    }
}
