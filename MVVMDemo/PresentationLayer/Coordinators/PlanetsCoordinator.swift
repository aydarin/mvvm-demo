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
    let api: APIClient
    
    fileprivate var childCoordinator: AuthorizationCoordinator?
    
    init(navigationController: UINavigationController, api: APIClient) {
        self.navigationController = navigationController
        self.api = api
    }
    
    func start() -> [UIViewController] {
        return [configuredListViewController()]
    }

}

extension PlanetsCoordinator: ListCoordinator {
    
    fileprivate func configuredListViewController() -> ListViewController {
        let provider = ListProviderImpl(api: api)
        
        let vm = ListViewModelImpl(provider: provider, coordinator: self)
        
        let vc = ListViewController.createStoryboardsInstance()
        vc.viewModel = vm
        
        return vc
    }
    
    func list(_ viewModel: ListViewModel, didSelect planet: Planet) {
        navigationController.pushViewController(configuredDetailsViewController(with: planet), animated: true)
    }
    
}

extension PlanetsCoordinator: DetailsCoordinator {
    
    fileprivate func configuredDetailsViewController(with planet: Planet) -> DetailsViewController {
        let provider = DetailsProviderImpl(with: planet, api: api)
        
        let vm = DetailsViewModelImpl(provider: provider, coordinator: self)
        
        let vc = DetailsViewController.createStoryboardsInstance()
        vc.viewModel = vm
        
        return vc
    }
    
    func detailsVoteFailed(_ viewModel: DetailsViewModel, retryBlock: @escaping (() -> ())) {
        startAuthorizationCoordinator { success in
            if success {
                retryBlock()
            }
        }
    }
    
}

extension PlanetsCoordinator {
    
    func startAuthorizationCoordinator(completion: @escaping ((Bool) -> ())) {
        let authorizationNC = UINavigationController()
        let coordinator = AuthorizationCoordinator(navigationController: authorizationNC, api: api) { [weak self] success in
            self?.childCoordinator = nil
            
            self?.navigationController.dismiss(animated: true, completion: {
                completion(success)
            })
        }
        
        authorizationNC.setViewControllers(coordinator.start(), animated: false)
        
        childCoordinator = coordinator
        navigationController.present(authorizationNC, animated: true, completion: nil)
    }
    
}
