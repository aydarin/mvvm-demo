//
//  ListDataSource.swift
//  MVVMDemo
//
//  Created by Aydar Mukhametzyanov on 6/13/17.
//  Copyright © 2017 Aydar Mukhametzyanov. All rights reserved.
//

import UIKit

protocol ListDataSource: UITableViewDataSource {
    var planets: [Planet] { get }
}

class ListDataSourceImpl: NSObject, ListDataSource {
    
    let planets: [Planet]
    
    init(planets: [Planet]) {
        self.planets = planets
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "planetCell", for: indexPath)
        cell.textLabel?.text = planets[indexPath.row].name
        
        return cell
    }
}

class EmptyListDataSourceImpl: NSObject, ListDataSource {
    
    let planets: [Planet] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "emptyCell", for: indexPath)
    }
}
