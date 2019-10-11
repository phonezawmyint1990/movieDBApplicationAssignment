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
        if UserDefaults.standard.string(forKey: SESSION_ID) != nil {
            userProfileLogin()
        }
    }
    
    func userProfileLogin(){
        let storboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storboard.instantiateViewController(withIdentifier: String(describing: UserDetailsViewController.self)) as! UINavigationController
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func btnLoginAction(_ sender: Any) {
        if txtEmail.text?.isEmpty ?? true {
            Dialog.showAlert(viewController: self, title: "Error", message: "Please fill Email")
        }else if txtPassword.text?.isEmpty ?? true {
            Dialog.showAlert(viewController: self, title: "Error", message: "Please fill Password")
        }else{
             fetchRequestToken(userId:txtEmail.text!,txtPassword:txtPassword.text!)
        }
    }
    
    fileprivate func fetchRequestToken(userId:String,txtPassword:String) {
            if NetworkUtils.checkReachable() == false {
                Dialog.showAlert(viewController: self, title: "Error", message: "No Internet Connection!")
                return
            }
            
            MovieModel.shared.fetchRequestToken { (requestToken) in
                guard let requestToken = requestToken.request_token else{return}
            MovieModel.shared.fetchRequestTokenWithAuthenticationLogin(request_Token: requestToken, completion: { (request) in
                    guard let requestToken = request.request_token else {return}
                    MovieModel.shared.fetchRequestSessionId(request_Token: requestToken, completion: { (sessionId) in
                        guard let sessionId = sessionId.session_id else{return}
                        UserDefaults.standard.set(sessionId, forKey: SESSION_ID)
                    })
                })
                
            }
        
    }
}
