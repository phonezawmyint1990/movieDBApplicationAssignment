//
//  MovieDetailsViewController.swift
//  movieDBapplicationAssignment
//
//  Created by Aung Ko Ko on 05/10/2019.
//  Copyright © 2019 Phone Zaw Myint. All rights reserved.
//

import UIKit
import RealmSwift
import SDWebImage
import AVKit
import YoutubePlayer_in_WKWebView


class MovieDetailsViewController: UIViewController {
    var movieId : Int = 0
    @IBOutlet weak var moreLikeCollectionView: UICollectionView!
    
    @IBOutlet weak var imagePosterView: UIImageView!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var lblAdult: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var lblOverview: UILabel!
    
    let videoPlayer = AVPlayerViewController()
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionViews()
        if let data = MovieVO.getMovieById(movieId: movieId, realm: realm) {
            self.bindData(data: data)
        }
    }
    
    fileprivate func bindData(data : MovieVO?) {
        print("Movie Details", data)
        if let data = data {
            imagePosterView.sd_setImage(with: URL(string: "\(API.BASE_IMG_URL)\(data.poster_path ?? "")"), placeholderImage: #imageLiteral(resourceName: "icon_home"), options:  SDWebImageOptions.progressiveLoad, completed: nil)
            lblReleaseDate.text = data.release_date
            lblDuration.text = "1h 3m"
            lblOverview.text = data.overview
            if data.adult {
                lblAdult.text = "18+"
            }else{
                lblAdult.text = ""
            }
        }
        
    }
    @IBAction func btnBackAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnMovieLikeAction(_ sender: Any) {
        LikeMovieVO.saveMovieBookmark(movieId: movieId, realm: realm)
    }
    
    @IBAction func btnRateAction(_ sender: Any) {
        RateMovieVO.saveMovieBookmark(movieId: movieId, realm: realm)
    }
    
    
    @IBAction func playMovie(_ sender: Any) {
        if NetworkUtils.checkReachable() == false {
            Dialog.showAlert(viewController: self, title: "Error", message: "No Internet Connection!")
            return
        }
        
        MovieModel.shared.fetchMovieVideo(movieId: movieId) { (movie) in
            print("Movies",movie)
            //let key = movie.first?.key
//            let key = "t433PEQGErc"
//            let videoURL = URL(string: "https://www.youtube.com/watch?v=\(key)")
//            print("vide",videoURL)
//            let video = AVPlayer(url: videoURL!)
//            let videoPlayer = AVPlayerViewController()
//            videoPlayer.player = video
//            self.present(videoPlayer, animated: true, completion: {
//                video.play()
//            if video.status == .failed {
//                videoPlayer.removeFromParent()
//            }
//            })
            
            if let path = Bundle.main.path(forResource: "JOKER - Teaser Trailer - Now Playing In Theaters", ofType: "mp4") {
                let video = AVPlayer(url: URL(fileURLWithPath: path))
                self.videoPlayer.player = video
                NotificationCenter.default.addObserver(self, selector: #selector(self.playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.videoPlayer.player?.currentItem)
                self.present(self.videoPlayer, animated: true, completion: {
                   self.videoPlayer.player?.play()
//                    if video.status == .failed {
//                        videoPlayer.removeFromParent()
//                    }
                })
            }
            
        }
    }
    
    @objc func playerDidFinishPlaying(note: NSNotification) {
        //self.dismiss(animated: true, completion: nil)
        self.videoPlayer.dismiss(animated: true, completion: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setUpCollectionViews(){
        moreLikeCollectionView.delegate = self
        moreLikeCollectionView.dataSource = self
        
        let layout = moreLikeCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 8
        layout.itemSize = CGSize(width: (self.view.frame.width), height: 180)
        
        moreLikeCollectionView.register(UINib(nibName: String(describing: InnerCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: InnerCollectionViewCell.self))
        moreLikeCollectionView.register(UINib(nibName: String(describing: SectionCollectionReusableView.self), bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader , withReuseIdentifier: String(describing: SectionCollectionReusableView.self))
    }
}

extension MovieDetailsViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: InnerCollectionViewCell.self), for: indexPath) as! InnerCollectionViewCell
        return item
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
}
extension MovieDetailsViewController: UICollectionViewDelegate{
        func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: SectionCollectionReusableView.self), for: indexPath) as! SectionCollectionReusableView
            sectionHeader.lblSectionTitle.text = "MORE LIKE THIS"
            return sectionHeader
        }
}
