//
//  ItemViewController.swift
//  SberProject
//
//  Created by Konstantin Nikandrov on 06.12.2019.
//  Copyright © 2019 Konstantin Nikandrov. All rights reserved.
//

import Foundation
import UIKit

let itemService = ItemsService.shared

class ItemViewController: UIViewController {
   
       
       override func viewDidLoad() {
           super.viewDidLoad()
           
           setupUI()
       }
       
       func setImage(imageURL : URL) {
                     DispatchQueue.main.async {
                         let data = try? Data(contentsOf: imageURL)
                         if let data = data {
                             let image = UIImage(data: data)
                             DispatchQueue.main.async {
                              self.MyImageView.image = image
                             }
                         }
                }
        }
              
       
    let MyImageView: UIImageView = {
             let img = UIImageView()
             img.contentMode = .scaleToFill
             img.translatesAutoresizingMaskIntoConstraints = false
             img.layer.masksToBounds = true
             return img
         }()
    
    let linkButton: UIButton = {
           let linkButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
           linkButton.backgroundColor = UIColor.blue
           linkButton.setTitle("Перейти на lamoda", for: .normal)
           linkButton.layer.cornerRadius = 15
           linkButton.addTarget( self, action: #selector(linkButtonAction), for: .touchUpInside)
           linkButton.translatesAutoresizingMaskIntoConstraints = false
           return linkButton
       }()
    
    @objc
    func linkButtonAction(){
        let fourthVC = WebVIewController()
        navigationController?.pushViewController(fourthVC, animated: true)
    }
    
    
    func setupUI() {
        //linkButton.center = CGPoint(x: view.center.x, y: view.center.y)
        linkButton.frame = view.frame
        view.addSubview(linkButton)
           
        MyImageView.frame = view.frame
        view.addSubview(MyImageView)
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            //MyImageView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            MyImageView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            MyImageView.widthAnchor.constraint(equalTo: safeArea.widthAnchor),
            MyImageView.heightAnchor.constraint(equalTo: safeArea.heightAnchor, constant: -100),
            MyImageView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            linkButton.topAnchor.constraint(equalTo: MyImageView.bottomAnchor),
            linkButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            linkButton.widthAnchor.constraint(equalTo: safeArea.widthAnchor)
            ])
       }
}
