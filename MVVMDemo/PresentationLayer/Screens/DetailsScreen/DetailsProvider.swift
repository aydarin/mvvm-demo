//
//  DetailsDataProvider.swift
//  MVVMDemo
//
//  Created by Aydar Mukhametzyanov on 6/12/17.
//  Copyright © 2017 Aydar Mukhametzyanov. All rights reserved.
//

class DetailsDataProvider {
    
    let planet: Planet
    private let api: APIClient
    
    init(with planet: Planet, api: APIClient) {
        self.planet = planet
        self.api = api
    }
    
    func vote(completion: @escaping ((Bool) -> ())) {
        api.performRequest {
            completion(APISession.isLoggedIn)
        }
    }

}
