//
//  PhotosCollotionViewCell.swift
//  ADVA
//
//  Created by iOSAYed on 17/01/2024.
//

import UIKit
import SDWebImage

class PhotosCollotionViewCell: UICollectionViewCell {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var idStackView: UIStackView!
    @IBOutlet private weak var idLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = 8
        containerView.clipsToBounds = true
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        
    }
    
    

    func setupPhotoCell(from data:PhotosResponseElement) {
        idStackView.isHidden = true
        imageView.setImageWithLoading(url: data.thumbnailURL)
        titleLabel.text = data.title
    }
    
    func setupAlbumCell(from data:AlbumsResponseElement) {
        idStackView.isHidden = false
        imageView.image = UIImage(named: "gallery")
        idLabel.text = String(describing: data.id)
        titleLabel.text = data.title
    }
}
