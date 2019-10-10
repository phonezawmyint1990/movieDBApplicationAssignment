//
//  UserDetailsViewController.swift
//  movieDBapplicationAssignment
//
//  Created by Aung Ko Ko on 09/10/2019.
//  Copyright © 2019 Phone Zaw Myint. All rights reserved.
//

import UIKit

class UserDetailsViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var userName: UILabel!
    
    var userId: String?
    var password: String?
    var tokenId:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "User Profile Details"
        collectionView.delegate = self
        collectionView.dataSource = self
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 8
        layout.itemSize = CGSize(width: (self.view.frame.width), height: 180)
        
        collectionView.register(UINib(nibName: String(describing: InnerCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: InnerCollectionViewCell.self))
        collectionView.reloadData()
        
        let sessionId = UserDefaults.standard.string(forKey: SESSION_ID)
        print(sessionId)
        MovieModel.shared.fetchAccount(sessionId: "54cc1b8daecc4dfc073ea6fc6cc3aefeb1eb783c") { (returnData) in
            print("Return Data",returnData)
        }
    }
    
    
}

extension UserDetailsViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: InnerCollectionViewCell.self), for: indexPath) as! InnerCollectionViewCell
        switch indexPath.row {
        case 0: break
           // item.movieList =
        case 1: break
           // item.movieList =
        default:
            break
        }
        return item
    }
    
    
}

extension UserDetailsViewController: UICollectionViewDelegate{
    
}
