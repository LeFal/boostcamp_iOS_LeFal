//
//  PhotoCollectionViewCell.swift
//  Photorama
//
//  Created by LEOFALCON on 2017. 7. 31..
//  Copyright © 2017년 LeFal. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView : UIImageView!
    @IBOutlet var spinner : UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateWithImage(image: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        updateWithImage(image: nil)
    }
    
    func updateWithImage(image: UIImage?) {
        if let imageToDisplay = image {
            spinner.stopAnimating()
            imageView.image = imageToDisplay
        }
        else {
            spinner.startAnimating()
            imageView.image = nil
        }
    }
}
