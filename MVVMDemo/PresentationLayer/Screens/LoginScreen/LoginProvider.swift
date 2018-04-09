//
//  LoginDataProvider.swift
//  MVVMDemo
//
//  Created by Aydar Mukhametzyanov on 6/16/17.
//  Copyright © 2017 Aydar Mukhametzyanov. All rights reserved.
//

import UIKit

class LoginDataProvider {
    
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
