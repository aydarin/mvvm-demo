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
    func detailsVoteFailed(_ viewModel: DetailsViewModel)
}

protocol DetailsUIDelegate: class {
    func voteSucceded()
    
    func didStartLoading()
    func didFinishLoading()
}

class DetailsViewModelImpl: DetailsViewModel {
    
    weak var uiDelegate: DetailsUIDelegate?
    weak var coordinator: DetailsCoordinator?
    
    var title: String {
        return model.planet.name
    }
    
    var detailedDescription: String {
        return model.planet.description
    }
    
    private let model: DetailsModel
    
    init(with model: DetailsModel) {
        self.model = model
    }
    
    private func voteFailed() {
        coordinator?.detailsVoteFailed(self)
    }
    
    //MARK: - Actions
    
    func votePressed() {
        uiDelegate?.didStartLoading()
        model.vote { [weak self] success in
            self?.uiDelegate?.didFinishLoading()
            
            if success {
                self?.voteFailed()
            } else {
                self?.uiDelegate?.voteSucceded()
            }
        }
    }
    
}
