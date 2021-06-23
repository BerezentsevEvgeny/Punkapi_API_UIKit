//
//  CustomCollectionViewCell.swift
//  TEST Collection
//
//  Created by Евгений Березенцев on 22.06.2021.
//

import UIKit


class CustomCollectionViewCell: UICollectionViewCell {
    static let identifier = "CustomCollectionViewCell"
    
    private let myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "house")
        imageView.backgroundColor = .yellow
        return imageView
    }()
    
    private let mylabel: UILabel = {
        let myLabel = UILabel()
        myLabel.text = "Hello World!"
        myLabel.backgroundColor = .green
        return myLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .blue
        contentView.addSubview(mylabel)
        contentView.addSubview(myImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        mylabel.frame = CGRect(x: 5,
                               y: contentView.frame.size.height - 50,
                               width: contentView.frame.size.width - 10,
                               height: 45)
        myImageView.frame = CGRect(x: 5,
                                   y: 5,
                                   width: contentView.frame.size.width - 10,
                                   height: contentView.frame.size.height - 55)
    }
    
    
    
}
