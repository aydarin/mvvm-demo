//
//  ListDataProvider.swift
//  MVVMDemo
//
//  Created by Aydar Mukhametzyanov on 6/13/17.
//  Copyright © 2017 Aydar Mukhametzyanov. All rights reserved.
//

class ListDataProvider {
    
    let api: APIClient
    
    init(api: APIClient) {
        self.api = api
    }
    
    func loadPlanets(completion: @escaping ([Planet])->()) {
        api.loadPlanets { planets in
            completion(planets)
        }
    }
    
}
