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
    
    
    public static let reuseId = "MyReuseID"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        MyImageView.frame = self.contentView.frame
        MyImageView.center = self.contentView.center
        contentView.addSubview(MyImageView)
        MyImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        MyImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        MyImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        MyImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
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
