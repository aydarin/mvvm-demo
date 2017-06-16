//
//  LoginViewModel.swift
//  MVVMDemo
//
//  Created by Aydar Mukhametzyanov on 6/16/17.
//  Copyright © 2017 Aydar Mukhametzyanov. All rights reserved.
//

import UIKit

protocol LoginCoordinator: class {
    func loginFinished()
    func loginCancelled()
}

protocol LoginUIDelegate: class {
    func didStartLoading()
    func didFinishLoading()
}

protocol LoginViewModel {
    var uiDelegate: LoginUIDelegate? { get set }
    
    func loginPressed()
    func cancelPressed()
}

class LoginViewModelImpl: LoginViewModel {
    
    weak var uiDelegate: LoginUIDelegate?
    private weak var coordinator: LoginCoordinator?
    private let provider: LoginProvider
    
    init(provider: LoginProvider, coordinator: LoginCoordinator) {
        self.provider = provider
        self.coordinator = coordinator
    }
    
    // MARK: Actions
    
    func loginPressed() {
        uiDelegate?.didStartLoading()
        
        provider.login { [weak self] in
            self?.uiDelegate?.didFinishLoading()
            self?.coordinator?.loginFinished()
        }
    }
    
    func cancelPressed() {
        coordinator?.loginCancelled()
    }

}
