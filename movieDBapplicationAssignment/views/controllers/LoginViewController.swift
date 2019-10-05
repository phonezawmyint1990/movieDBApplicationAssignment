//
//  LoginViewController.swift
//  movieDBapplicationAssignment
//
//  Created by Aung Ko Ko on 03/10/2019.
//  Copyright © 2019 Phone Zaw Myint. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnSignIn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Login"
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "img_netflixlogo")
        imageView.image = image
        self.navigationItem.titleView = imageView
        btnSignIn.layer.cornerRadius = 5
        btnSignIn.layer.borderWidth = 1
        btnSignIn.layer.borderColor = #colorLiteral(red: 0.4352941215, green: 0.4431372583, blue: 0.4745098054, alpha: 1)
        fetchRequestToken()
    }
    
    fileprivate func fetchRequestToken() {
        if NetworkUtils.checkReachable() == false {
            Dialog.showAlert(viewController: self, title: "Error", message: "No Internet Connection!")
            return
        }
            MovieModel.shared.fetchRequestToken { (requestToken) in
                guard let requestToken = requestToken.request_token else{return}
                print("RequestToken",requestToken)
                MovieModel.shared.fetchRequestSessionId(request_Token: requestToken, completion: { (sessionId) in
                    guard let sessionId = sessionId.session_id else{return}
                    print("Session Id\(sessionId)")
                })
            }
    }
}
