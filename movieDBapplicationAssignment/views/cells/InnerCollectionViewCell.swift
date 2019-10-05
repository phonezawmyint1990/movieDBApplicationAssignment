//
//  InnerCollectionViewCell.swift
//  movieDBapplicationAssignment
//
//  Created by Aung Ko Ko on 04/10/2019.
//  Copyright © 2019 Phone Zaw Myint. All rights reserved.
//

import UIKit
import RealmSwift

class InnerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieCollectionView: UICollectionView!
    let realm = try! Realm()
    var movieList : Results<MovieVO>?
    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        
        let layout = movieCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 10
        //layout.itemSize = CGSize(width: (self.frame.width - 20)/3, height: 180)
        layout.itemSize = CGSize(width: 100, height: 150)
        
        movieCollectionView.register(UINib(nibName: String(describing: MovieCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: MovieCollectionViewCell.self))
         self.movieList = realm.objects(MovieVO.self)
    }

    
}

extension InnerCollectionViewCell: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = movieList![indexPath.row]
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieCollectionViewCell.self), for: indexPath) as! MovieCollectionViewCell
        item.data = movie
        item.delegate = self
        return item
    }
}
extension InnerCollectionViewCell: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension InnerCollectionViewCell: MovieDetailsDelegate {
    func onClickMovieDetails(objMovie: MovieVO) {
        let storboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storboard.instantiateViewController(withIdentifier: String(describing: MovieDetailsViewController.self)) as! MovieDetailsViewController
        
        self.window?.rootViewController?.present(vc, animated: true)
    }
}
