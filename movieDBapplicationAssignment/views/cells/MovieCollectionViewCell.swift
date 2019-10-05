//
//  MovieCollectionViewCell.swift
//  movieDBapplicationAssignment
//
//  Created by Aung Ko Ko on 03/10/2019.
//  Copyright © 2019 Phone Zaw Myint. All rights reserved.
//

import UIKit
import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageViewMoviePoster: UIImageView!
    var data : MovieVO? {
        didSet {
            if let data = data {
                imageViewMoviePoster.sd_setImage(with: URL(string: "\(API.BASE_IMG_URL)\(data.poster_path ?? "")"), placeholderImage: #imageLiteral(resourceName: "icon_home"), options:  SDWebImageOptions.progressiveLoad, completed: nil)
            }
        }
    }
     var delegate : MovieDetailsDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initGeusterRecognizer()
    }
    private func initGeusterRecognizer(){
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onclickViewDetails))
    imageViewMoviePoster.isUserInteractionEnabled = true
    imageViewMoviePoster.addGestureRecognizer(tapGesture)
    }

    @objc func onclickViewDetails(){
        if let movie = data {
            delegate?.onClickMovieDetails(objMovie: movie)
        }
    }
}
