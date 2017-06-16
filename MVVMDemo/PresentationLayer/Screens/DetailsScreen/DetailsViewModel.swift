//
//  DetailsViewModel.swift
//  MVVMDemo
//
//  Created by Aydar Mukhametzyanov on 6/12/17.
//  Copyright © 2017 Aydar Mukhametzyanov. All rights reserved.
//

protocol DetailsViewModel {
    var title: String { get }
    var detailedDescription: String { get }
    
    var uiDelegate: DetailsUIDelegate? { get set }
    
    func votePressed()
}

protocol DetailsCoordinator: class {
    func detailsVoteFailed(_ viewModel: DetailsViewModel, retryBlock: @escaping (() -> ()))
}

protocol DetailsUIDelegate: class {
    func voteSucceded()
    
    func didStartLoading()
    func didFinishLoading()
}

class DetailsViewModelImpl: DetailsViewModel {
    
    weak var uiDelegate: DetailsUIDelegate?
    private weak var coordinator: DetailsCoordinator?
    
    var title: String {
        return provider.planet.name
    }
    
    var detailedDescription: String {
        return provider.planet.description
    }
    
    private let provider: DetailsProvider
    
    init(provider: DetailsProvider, coordinator: DetailsCoordinator) {
        self.provider = provider
        self.coordinator = coordinator
    }
    
    private func voteFailed() {
        coordinator?.detailsVoteFailed(self) { [weak self] in
            self?.votePressed()
        }
    }
    
    //MARK: - Actions
    
    func votePressed() {
        uiDelegate?.didStartLoading()
        provider.vote { [weak self] success in
            self?.uiDelegate?.didFinishLoading()
            
            if success {
                self?.uiDelegate?.voteSucceded()
            } else {
                self?.voteFailed()
            }
        }
    }
    
}
