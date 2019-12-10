//
//  TableViewCell.swift
//  SberProject
//
//  Created by Konstantin Nikandrov on 05.12.2019.
//  Copyright © 2019 Konstantin Nikandrov. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    let MyImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleToFill
        img.translatesAutoresizingMaskIntoConstraints = false

        img.layer.masksToBounds = true
        return img
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 1
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
       
        return titleLabel
    }()
    
    let priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.numberOfLines = 1
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.textAlignment = .center
        
        return priceLabel
    }()
    
    public static let reuseId = "MyReuseID"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
       // MyImageView.frame = self.contentView.frame
       // MyImageView.center = self.contentView.center
        contentView.addSubview(titleLabel)
        contentView.addSubview(MyImageView)
        contentView.addSubview(priceLabel)
        NSLayoutConstraint.activate([
                    MyImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                    MyImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 100),
                    MyImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -100),
                    MyImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -100),
                    titleLabel.topAnchor.constraint(equalTo: MyImageView.bottomAnchor),
                    titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
                    titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50),
                    priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
                    priceLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
                    priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
                   ])
       
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

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:)has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
}
