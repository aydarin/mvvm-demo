//
//  ListModel.swift
//  MVVMDemo
//
//  Created by Aydar Mukhametzyanov on 6/13/17.
//  Copyright © 2017 Aydar Mukhametzyanov. All rights reserved.
//

protocol ListModel {
    func loadPlanets(completion: @escaping ([Planet])->())
}

class ListModelImpl: ListModel {
    
    let api: APIClient
    
    init(api: APIClient) {
        self.api = api
    }
    
    func loadPlanets(completion: @escaping ([Planet])->()) {
        api.performRequest {
            completion([
                Planet(name: "Earth", description: "Third planet")
                ])
        }
    }
    
}
