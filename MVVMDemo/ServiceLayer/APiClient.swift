//
//  APiClient.swift
//  MVVMDemo
//
//  Created by Aydar Mukhametzyanov on 6/12/17.
//  Copyright © 2017 Aydar Mukhametzyanov. All rights reserved.
//

import UIKit

protocol APIClient {
    func performRequest(completion: @escaping (() -> ()))
    func login(completion: @escaping (() -> ()))
}

class APIClientImpl: APIClient {
    
    func login(completion: @escaping (() -> ())) {
        performRequest {
            APISession.isLoggedIn = true
            completion()
        }
    }
    
    func performRequest(completion: @escaping (() -> ())) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(250)) {
            completion()
        }
    }
    
}
