//
//  DetailsViewModel.swift
//  MVVMDemo
//
//  Created by Aydar Mukhametzyanov on 6/12/17.
//  Copyright © 2017 Aydar Mukhametzyanov. All rights reserved.
//

protocol DetailsUIDelegate: class {
    func voteSucceded()
    
    func didStartLoading()
    func didFinishLoading()
}

struct RetryCommand {
    let run: () -> ()
}

class DetailsViewModel {
    
    private let dataProvider: DetailsDataProvider
    private weak var uiDelegate: DetailsUIDelegate?
    private let onFailed: (RetryCommand) -> ()
    
    var title: String {
        return dataProvider.planet.name
    }
    
    var detailedDescription: String {
        return dataProvider.planet.description
    }
    
    init(dataProvider: DetailsDataProvider,
         uiDelegate: DetailsUIDelegate,
         onFailed: @escaping (RetryCommand) -> ()) {
        self.dataProvider = dataProvider
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
        dataProvider.vote { [weak self] success in
            self?.uiDelegate?.didFinishLoading()
            
            if success {
                self?.uiDelegate?.voteSucceded()
            } else {
                self?.voteFailed()
            }
        }
    }
    
}
