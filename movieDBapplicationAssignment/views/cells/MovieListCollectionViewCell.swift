//
//  MovieListCollectionViewCell.swift
//  movieDBapplicationAssignment
//
//  Created by Aung Ko Ko on 05/10/2019.
//  Copyright © 2019 Phone Zaw Myint. All rights reserved.
//

import UIKit
import SDWebImage

class MovieListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageViewMoviePoster : UIImageView!
    
    var data : MovieVO? {
        didSet {
            if let data = data {
                imageViewMoviePoster.sd_setImage(with: URL(string: "\(API.BASE_IMG_URL)\(data.poster_path ?? "")"), placeholderImage: #imageLiteral(resourceName: "icon_home"), options:  SDWebImageOptions.progressiveLoad, completed: nil)
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static var identifier : String {
        return String(describing: self)
    }
}
