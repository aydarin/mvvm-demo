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
    
    func votePressed()
}

protocol DetailsUIDelegate: class {
    func voteSucceded()
    
    func didStartLoading()
    func didFinishLoading()
}

struct RetryCommand {
    let run: () -> ()
}

class DetailsViewModelImpl: DetailsViewModel {
    
    private let provider: DetailsProvider
    private weak var uiDelegate: DetailsUIDelegate?
    private let onFailed: (RetryCommand) -> ()
    
    var title: String {
        return provider.planet.name
    }
    
    var detailedDescription: String {
        return provider.planet.description
    }
    
    init(provider: DetailsProvider,
         uiDelegate: DetailsUIDelegate,
         onFailed: @escaping (RetryCommand) -> ()) {
        self.provider = provider
        self.uiDelegate = uiDelegate
        self.onFailed = onFailed
    }
    
    private func voteFailed() {
        onFailed(RetryCommand(run: { [weak self] in
            self?.votePressed()
        }))
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
