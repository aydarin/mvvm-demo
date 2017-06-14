//
//  PlanetsCoordinator.swift
//  MVVMDemo
//
//  Created by Aydar Mukhametzyanov on 6/13/17.
//  Copyright © 2017 Aydar Mukhametzyanov. All rights reserved.
//

import UIKit

class PlanetsCoordinator {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

}

extension PlanetsCoordinator: ListCoordinator {
    
    private func configuredListViewController() -> ListViewController {
        
    }
    
    func list(_ viewModel: ListViewModel, selectedPlanet planet: Planet) {
        
    }
    
}

extension PlanetsCoordinator: DetailsCoordinator {
    
    private func configuredDetailsViewController() -> DetailsViewController {
        
    }
    
    func detailsVoteFailed(_ viewModel: DetailsViewModel) {
        
    }
    
}
