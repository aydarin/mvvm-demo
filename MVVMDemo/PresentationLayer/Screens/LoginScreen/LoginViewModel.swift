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

class LoginViewModel {
    
    private weak var uiDelegate: LoginUIDelegate?
    private let dataProvider: LoginDataProvider
    
    private let onFinished: () -> ()
    private let onCancelled: () -> ()
    
    init(dataProvider: LoginDataProvider,
         uiDelegate: LoginUIDelegate,
         onFinished: @escaping () -> (),
         onCancelled: @escaping () -> ()) {
        self.dataProvider = dataProvider
        self.uiDelegate = uiDelegate
        self.onFinished = onFinished
        self.onCancelled = onCancelled
    }
    
    // MARK: Actions
    
    func loginPressed() {
        uiDelegate?.didStartLoading()
        
        dataProvider.login { [weak self] in
            self?.uiDelegate?.didFinishLoading()
            self?.onFinished()
        }
    }
    
    func cancelPressed() {
        onCancelled()
    }

}
