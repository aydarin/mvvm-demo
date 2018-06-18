//
//  DetailsDataProvider.swift
//  MVVMDemo
//
//  Created by Aydar Mukhametzyanov on 6/12/17.
//  Copyright © 2017 Aydar Mukhametzyanov. All rights reserved.
//

import WatchConnectivity


class DetailsDataProvider {
    
    let planet: Planet
    private let api: APIClient
    private var session: WCSession?
    
    init(with planet: Planet, api: APIClient) {
        self.planet = planet
        self.api = api
    }
    
    func vote(completion: @escaping ((Bool) -> ())) {
        api.performRequest {
            completion(APISession.isLoggedIn)
        }
    }
    
    func setupWatchSession(with delegate: WCSessionDelegate) {
        if WCSession.isSupported() {
                session = WCSession.default
            session?.delegate = delegate
            
            if session?.activationState != .activated {
                session?.activate()
            }
        }
    }

}
