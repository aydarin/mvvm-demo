//
//  ListInterfaceController.swift
//  MVVMDemo
//
//  Created by Aydar Mukhametzyanov on 6/17/18.
//  Copyright © 2018 Aydar Mukhametzyanov. All rights reserved.
//

import WatchKit
import Foundation


class PlanetRowController: NSObject {
    var planet: Planet? {
        didSet {
            nameLabel.setText(planet?.name)
        }
    }
    
    @IBOutlet private weak var nameLabel: WKInterfaceLabel!
}

class ListInterfaceController: WKInterfaceController {

    @IBOutlet private var table: WKInterfaceTable!
    
    private var planets: [Planet] = [] {
        didSet {
            reloadTable()
        }
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        reloadTable()
    }

    override func willActivate() {
        super.willActivate()
        
        PersistentDataLoader().loadPlanets { [weak self] planets in
            self?.planets = planets
        }
    }
    
    private func reloadTable() {
        table.setNumberOfRows(planets.count, withRowType: "PlanetRow")
        
        for i in 0..<table.numberOfRows {
            if let row = table.rowController(at: i) as? PlanetRowController {
                row.planet = planets[i]
            }
        }
    }
    
    // MARK: - TableDelegate
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        pushController(withName: "DetailsInterfaceController", context: planets[rowIndex])
    }

}
