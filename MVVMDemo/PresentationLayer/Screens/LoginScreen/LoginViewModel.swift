//
//  LoginViewModel.swift
//  MVVMDemo
//
//  Created by Aydar Mukhametzyanov on 6/16/17.
//  Copyright © 2017 Aydar Mukhametzyanov. All rights reserved.
//

import UIKit

protocol LoginUIDelegate: class {
    func didStartLoading()
    func didFinishLoading()
}

protocol LoginViewModel {
    func loginPressed()
    func cancelPressed()
}

class LoginViewModelImpl: LoginViewModel {
    
    private weak var uiDelegate: LoginUIDelegate?
    private let provider: LoginProvider
    
    private let onFinished: () -> ()
    private let onCancelled: () -> ()
    
    init(provider: LoginProvider,
         uiDelegate: LoginUIDelegate,
         onFinished: @escaping () -> (),
         onCancelled: @escaping () -> ()) {
        self.provider = provider
        self.uiDelegate = uiDelegate
        self.onFinished = onFinished
        self.onCancelled = onCancelled
    }
    
    // MARK: Actions
    
    func loginPressed() {
        uiDelegate?.didStartLoading()
        
        provider.login { [weak self] in
            self?.uiDelegate?.didFinishLoading()
            self?.onFinished()
        }
    }
    
    func cancelPressed() {
        onCancelled()
    }

}
