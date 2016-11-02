//
//  CellCollectionViewCell.swift
//  Lab4_v6
//
//  Created by Mai Dao on 10/29/16.
//  Copyright © 2016 Mai Dao. All rights reserved.
//

import UIKit
let kCellWidth: CGFloat = 110
class ACell: UICollectionViewCell {
    
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubviews()
    }

    override var intrinsicContentSize : CGSize {
        return CGSize(width: kCellWidth, height: kCellWidth);
    }
    
    func addSubviews() {
        if (imageView == nil) {
            imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: kCellWidth, height: kCellWidth))
            imageView.layer.borderColor = tintColor.cgColor
            contentView.addSubview(imageView)
        }
    }

    override var isSelected: Bool {
        didSet {
            imageView.layer.borderWidth = isSelected ? 2 : 0
        }
    }
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
        self.imageView.image = nil
    }
    
}
