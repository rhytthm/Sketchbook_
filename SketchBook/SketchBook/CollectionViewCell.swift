//
//  CollectionViewCell.swift
//  SketchBook
//
//  Created by Rhytthm Mahajan on 19/02/23.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    func configure(with: UIImage?){
        if let image = with{
            imageView.image = image
            imageView.isHidden = false
        }else{
            imageView.isHidden = true
        }
    }
}
