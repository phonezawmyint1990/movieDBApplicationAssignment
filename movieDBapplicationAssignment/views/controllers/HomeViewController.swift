//
//  HomeViewController.swift
//  movieDBapplicationAssignment
//
//  Created by Aung Ko Ko on 03/10/2019.
//  Copyright © 2019 Phone Zaw Myint. All rights reserved.
//

import UIKit
import RealmSwift

class HomeViewController: UIViewController {
    
    let netFlixButton = UIButton()
    let realm = try! Realm()
    var movieList : Results<MovieVO>?
    private var toprateMovieListNotifierToken : NotificationToken?
    private var popularMovieListNotifierToken : NotificationToken?
    private var nowplayingMovieListNotifierToken : NotificationToken?
    private var upcomingMovieListNotifierToken : NotificationToken?
    
    var topRateMoviesList : Results<MovieVO>?
    var popularMoviesList : Results<MovieVO>?
    var upComingMoviesList : Results<MovieVO>?
    var nowPlayingMoviesList : Results<MovieVO>?
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:#selector(handleRefresh(_:)),for: .valueChanged)
        refreshControl.tintColor = UIColor.red
        return refreshControl
    }()
    
    lazy var activityIndicator : UIActivityIndicatorView = {
        let ui = UIActivityIndicatorView()
        ui.translatesAutoresizingMaskIntoConstraints = false
        ui.startAnimating()
        ui.style = UIActivityIndicatorView.Style.whiteLarge
        return ui
    }()
    
    @IBOutlet weak var outerCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionViews()
        netFlixButton.setImage(#imageLiteral(resourceName: "img_netflixicon") ,for: .normal)
        netFlixButton.frame = CGRect(x: 0, y: 0, width: 10, height: 20)
        let barButtonItem = UIBarButtonItem.init(customView: netFlixButton)
        self.navigationItem.leftBarButtonItem = barButtonItem
        
        self.outerCollectionView.addSubview(refreshControl)
        self.view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true
        activityIndicator.startAnimating()
        
        initGenreListFetchRequest()
        initMovieListFetchRequest()
        fetchDataFromDatabase()
        activityIndicator.stopAnimating()
        outerCollectionView.reloadData()
    }
    

    
    @IBAction func unwindToMain(_ unwindSegue: UIStoryboardSegue) {}
    
    private func setUpCollectionViews(){
        outerCollectionView.delegate = self
        outerCollectionView.dataSource = self
        
        let layout = outerCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 8
        layout.itemSize = CGSize(width: (self.view.frame.width), height: 180)
        
        outerCollectionView.register(UINib(nibName: String(describing: InnerCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: InnerCollectionViewCell.self))
//        outerCollectionView.register(UINib(nibName: String(describing: SectionCollectionReusableView.self), bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader , withReuseIdentifier: String(describing: SectionCollectionReusableView.self))
        
        
    }
    
    private func fetchDataFromDatabase(){
        let predicatePopularMovie = NSPredicate(format: "category == %@", "PopularMovie");
        do {
            var popularMovies = try realm.objects(MovieVO.self).filter(predicatePopularMovie)
            self.popularMoviesList = popularMovies
            print("kdjfkdfjkdf",self.popularMoviesList?.toArray(type: MovieVO.self))
        } catch let err{
            print(err.localizedDescription)
        }
        
        let predicateTopRate = NSPredicate(format: "category == %@", "TopRate");
        do {
            let topRateMovies = try realm.objects(MovieVO.self).filter(predicateTopRate)
            self.topRateMoviesList = topRateMovies
        } catch let err{
            print(err.localizedDescription)
        }
        
        let predicateNowPlaying = NSPredicate(format: "category == %@", "NowPlaying");
        do {
            let nowPlayingMovies = try realm.objects(MovieVO.self).filter(predicateNowPlaying)
            self.nowPlayingMoviesList = nowPlayingMovies
        } catch let err{
            print(err.localizedDescription)
        }
        
        let predicateUpComing = NSPredicate(format: "category == %@", "UpComing");
        do {
            let upComingMovies = try realm.objects(MovieVO.self).filter(predicateUpComing)
            self.upComingMoviesList = upComingMovies
        } catch let err{
            print(err.localizedDescription)
        }
        outerCollectionView.reloadData()
    }
    
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        if self.movieList!.isEmpty {
            fetchPopularMovies()
            fetchTopRatesMovies()
            fetchNowPlayingMovies()
            fetchUpComingMovies()
            outerCollectionView.reloadData()
        }
        fetchDataFromDatabase()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Movies"
        fetchDataFromDatabase()
    }
    
    fileprivate func initMovieListFetchRequest() {
        
        //TODO: Setup Realm Notification Observer
          self.movieList = realm.objects(MovieVO.self)
//        popularMovieListNotifierToken = popularMoviesList?.observe { [weak self] changes in
//            switch changes {
//            case .initial:
//                //Update UI
//                self?.outerCollectionView.reloadData()
//                break
//            case .update(_,let deletions,let insertions,let modifications):
//                //Update UI
//                self?.outerCollectionView.performBatchUpdates({
//                    self?.outerCollectionView.deleteItems(at: deletions.map{row in IndexPath(row: row, section: 0)})
//                    self?.outerCollectionView.insertItems(at: insertions.map{row in IndexPath(row: row, section: 0)})
//                    self?.outerCollectionView.reloadItems(at: modifications.map{row in IndexPath(row: row, section: 0)})
//                }, completion: nil)
//                break
//            case .error:
//                print("realm obersever error")
//            }
//        }
        activityIndicator.startAnimating()
        if self.movieList!.isEmpty {
            fetchPopularMovies()
            fetchTopRatesMovies()
            fetchNowPlayingMovies()
            fetchUpComingMovies()
            outerCollectionView.reloadData()
        }
        fetchDataFromDatabase()
        self.activityIndicator.stopAnimating()
        self.refreshControl.endRefreshing()
    }
    
    fileprivate func initGenreListFetchRequest() {
        let genres = realm.objects(MovieGenreVO.self)
        if genres.isEmpty {
            MovieModel.shared.fetchMovieGenres{ genres in
                genres.forEach { [weak self] genre in
                    DispatchQueue.main.async {
                        MovieGenreResponse.saveMovieGenre(data: genre, realm: self!.realm)
                    }
                }
            }
        }
        
    }
    
    private func fetchPopularMovies(){
        if NetworkUtils.checkReachable() == false {
            Dialog.showAlert(viewController: self, title: "Error", message: "No Internet Connection!")
            return
        }
        
        for index in 0...5 {
            MovieModel.shared.fetchPopularMovies(pageId: index) { [weak self] movies in
                DispatchQueue.main.async { [weak self] in
                    movies.forEach{ movie in
                        MovieInfoResponse.saveMovie(data: movie, realm: self!.realm, category: "PopularMovie")
                    }
                }

            }
            
        }

    }
    
    private func fetchTopRatesMovies(){
        if NetworkUtils.checkReachable() == false {
            Dialog.showAlert(viewController: self, title: "Error", message: "No Internet Connection!")
            return
        }
        
        for index in 0...5 {
            MovieModel.shared.fetchTopRatedMovies(pageId: index) { [weak self] movies in
                DispatchQueue.main.async { [weak self] in
                    movies.forEach{ movie in
                        MovieInfoResponse.saveMovie(data: movie, realm: self!.realm, category: "TopRate")
                    }
                }
            }
        }
        
    }
    
    private func fetchNowPlayingMovies(){
        if NetworkUtils.checkReachable() == false {
            Dialog.showAlert(viewController: self, title: "Error", message: "No Internet Connection!")
            return
        }
        for index in 0...5 {
            MovieModel.shared.fetchNowPlayingMovies(pageId: index) { [weak self] movies in
                DispatchQueue.main.async { [weak self] in
                    movies.forEach{ movie in
                        MovieInfoResponse.saveMovie(data: movie, realm: self!.realm, category: "NowPlaying")
                    }
                }
            }
        }
        
    }
    
    private func fetchUpComingMovies(){
        if NetworkUtils.checkReachable() == false {
            Dialog.showAlert(viewController: self, title: "Error", message: "No Internet Connection!")
            return
        }
        for index in 0...5 {
            MovieModel.shared.fetchUpComingMovies(pageId: index) { [weak self] movies in
                DispatchQueue.main.async { [weak self] in
                    movies.forEach{ movie in
                        MovieInfoResponse.saveMovie(data: movie, realm: self!.realm, category: "UpComing")
                    }
                }
            }
        }
        
    }

}

extension HomeViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: InnerCollectionViewCell.self), for: indexPath) as! InnerCollectionViewCell
        switch indexPath.row{
        case 0:
            item.bindData((self.topRateMoviesList?.toArray(type: MovieVO.self))!,movieHeader: "Top Movies")
        case 1:
            item.bindData((self.popularMoviesList?.toArray(type: MovieVO.self))!, movieHeader: "Trending Movies")
        case 2:
            item.bindData((self.nowPlayingMoviesList?.toArray(type: MovieVO.self))!, movieHeader: "Now Playing Movies")
        case 3:
            item.bindData((self.upComingMoviesList?.toArray(type: MovieVO.self))!, movieHeader: "Up Coming Movies")
        default:
            break
        }
        return item
    }
    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }

    
    
}
extension HomeViewController : UICollectionViewDelegate{
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: SectionCollectionReusableView.self), for: indexPath) as! SectionCollectionReusableView
//        sectionHeader.lblSectionTitle.text = ""
//        return sectionHeader
//    }
}

extension Results {
    func toArray<T>(type: T.Type) -> [T] {
        return compactMap { $0 as? T }
    }
}
