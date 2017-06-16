//
//  LoginProvider.swift
//  MVVMDemo
//
//  Created by Aydar Mukhametzyanov on 6/16/17.
//  Copyright © 2017 Aydar Mukhametzyanov. All rights reserved.
//

import UIKit

protocol LoginProvider {
    func login(completion: @escaping (() -> ()))
}

class LoginProviderImpl: LoginProvider {
    
    let api: APIClient
    
    init(api: APIClient) {
        self.api = api
    }
    
    func login(completion: @escaping (() -> ())) {
        api.login {
            completion()
        }
    }
    
}
