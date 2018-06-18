//
//  PersistentDataLoader.swift
//  MVVMDemo
//
//  Created by Aydar Mukhametzyanov on 6/17/18.
//  Copyright © 2018 Aydar Mukhametzyanov. All rights reserved.
//

import Foundation

class PersistentDataLoader {

    func loadPlanets(completion: @escaping (([Planet]) -> ())) {
        var array: [Planet] = []
        
        if let path = Bundle.main.path(forResource: "Planets", ofType: "plist"),
            let objcArray = NSArray(contentsOfFile: path) as? [[String : String]] {
            
            array = Array(objcArray).compactMap { data in
                guard let name = data["Name"], let description = data["Description"] else {
                    return nil
                }
                return Planet(name: name, description: description)
            }
        }
        
        completion(array)
    }

}
