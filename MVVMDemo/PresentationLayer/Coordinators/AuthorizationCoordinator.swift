//
//  AuthorizationCoordinator.swift
//  MVVMDemo
//
//  Created by Aydar Mukhametzyanov on 6/16/17.
//  Copyright © 2017 Aydar Mukhametzyanov. All rights reserved.
//

import UIKit

class AuthorizationCoordinator {
    
    fileprivate let navigationController: UINavigationController
    fileprivate let api: APIClient
    fileprivate let completion: ((Bool) -> ())
    
    init(navigationController: UINavigationController,
         api: APIClient,
         completion: @escaping ((Bool) -> ())) {
        
        self.navigationController = navigationController
        self.api = api
        self.completion = completion
    }
    
    func start() -> [UIViewController] {
        return [configuredLoginViewController()]
    }

}

extension AuthorizationCoordinator: LoginCoordinator {
    
    func configuredLoginViewController() -> LoginViewController {
        let provider = LoginProviderImpl(api: api)
        
        let vm = LoginViewModelImpl(provider: provider, coordinator: self)
        
        let vc = LoginViewController.createStoryboardsInstance()
        vc.viewModel = vm
        
        return vc
    }
    
    func loginFinished() {
        completion(true)
    }
    
    func loginCancelled() {
        completion(false)
    }
    
}
