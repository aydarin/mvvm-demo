//
//  AuthorizationCoordinator.swift
//  MVVMDemo
//
//  Created by Aydar Mukhametzyanov on 6/16/17.
//  Copyright © 2017 Aydar Mukhametzyanov. All rights reserved.
//

import UIKit

class AuthorizationCoordinator {
    
    private weak var navigationController: UINavigationController?
    private let api: APIClient
    private let onFinish: ((Bool) -> ())
    
    init(navigationController: UINavigationController,
         api: APIClient,
         onFinish: @escaping ((Bool) -> ())) {
        
        self.navigationController = navigationController
        self.api = api
        self.onFinish = onFinish
    }
    
    func start() -> [UIViewController] {
        return [configuredLoginViewController()]
    }
    
    func configuredLoginViewController() -> LoginViewController {
        let provider = LoginProviderImpl(api: api)
        
        let vc = LoginViewController.createStoryboardsInstance()
        let vm = LoginViewModelImpl(provider: provider,
                                    uiDelegate: vc,
                                    onFinished: { self.onFinish(true) },
                                    onCancelled: { self.onFinish(false) })
        
        vc.viewModel = vm
        
        return vc
    }
    
}
