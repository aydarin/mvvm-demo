//
//  LoginViewController.swift
//  MVVMDemo
//
//  Created by Aydar Mukhametzyanov on 6/16/17.
//  Copyright © 2017 Aydar Mukhametzyanov. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var viewModel: LoginViewModel!
    
    @IBOutlet fileprivate weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Login"
    }
    
    // MARK: - Actions
    
    @IBAction func loginPressed(_ sender: Any) {
        viewModel.loginPressed()
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        viewModel.cancelPressed()
    }
    
    // MARK: - Utils
    
    static func createStoryboardsInstance() -> LoginViewController {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
            .instantiateViewController(withIdentifier: "loginScreen") as! LoginViewController
    }
}

extension LoginViewController: LoginUIDelegate {
    
    func didStartLoading() {
        activityIndicator.startAnimating()
    }
    
    func didFinishLoading() {
        activityIndicator.stopAnimating()
    }
    
}
