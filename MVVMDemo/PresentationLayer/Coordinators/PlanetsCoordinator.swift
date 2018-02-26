//
//  PlanetsCoordinator.swift
//  MVVMDemo
//
//  Created by Aydar Mukhametzyanov on 6/13/17.
//  Copyright © 2017 Aydar Mukhametzyanov. All rights reserved.
//

import UIKit

class PlanetsCoordinator {
    
    private weak var navigationController: UINavigationController?
    private let api: APIClient
    
    init(navigationController: UINavigationController, api: APIClient) {
        self.navigationController = navigationController
        self.api = api
    }
    
    func start() -> [UIViewController] {
        return [configuredListViewController()]
    }
    
    private func configuredListViewController() -> ListViewController {
        let vc = ListViewController.createStoryboardsInstance()
        let provider = ListProviderImpl(api: api)
        let vm = ListViewModelImpl(provider: provider, uiDelegate: vc, onSelect: { planet in
            let vc = self.configuredDetailsViewController(with: planet)
            self.navigationController?.pushViewController(vc, animated: true)
        })
        
        vc.viewModel = vm
        
        return vc
    }
    
    private func configuredDetailsViewController(with planet: Planet) -> DetailsViewController {
        let vc = DetailsViewController.createStoryboardsInstance()
        let provider = DetailsProviderImpl(with: planet, api: api)
        let vm = DetailsViewModelImpl(provider: provider,
                                      uiDelegate: vc,
                                      onFailed: { retryCommand in
                                        self.startAuthorizationCoordinator(completion: { success in
                                            if success {
                                                retryCommand.run()
                                            }
                                        })
        })
        
        vc.viewModel = vm
        
        return vc
    }
    
    private func startAuthorizationCoordinator(completion: @escaping ((Bool) -> ())) {
        let authorizationNC = UINavigationController()
        let coordinator = AuthorizationCoordinator(navigationController: authorizationNC, api: api) { success in
            self.navigationController?.dismiss(animated: true, completion: {
                completion(success)
            })
        }
        
        authorizationNC.setViewControllers(coordinator.start(), animated: false)
        navigationController?.present(authorizationNC, animated: true, completion: nil)
    }
    
}
