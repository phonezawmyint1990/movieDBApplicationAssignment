//
//  MovieViewController.swift
//  movieDBapplicationAssignment
//
//  Created by Aung Ko Ko on 10/10/2019.
//  Copyright © 2019 Phone Zaw Myint. All rights reserved.
//

import UIKit
import YoutubePlayer_in_WKWebView

class MovieViewController: UIViewController {
    @IBOutlet weak var movieView: WKYTPlayerView!
    var movieKey: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        movieView.load(withVideoId: self.movieKey)
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
