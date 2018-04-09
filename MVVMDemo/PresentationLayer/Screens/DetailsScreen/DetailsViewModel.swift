//
//  DetailsViewModel.swift
//  MVVMDemo
//
//  Created by Aydar Mukhametzyanov on 6/12/17.
//  Copyright © 2017 Aydar Mukhametzyanov. All rights reserved.
//

protocol DetailsUIDelegate: class {
    func voteSucceded()
    func voteFailed()
    
    func didStartLoading()
    func didFinishLoading()
}

struct RetryCommand {
    let run: () -> ()
}

class DetailsViewModel {
    
    private let dataProvider: DetailsDataProvider
    private weak var uiDelegate: DetailsUIDelegate?
    
    var title: String {
        return dataProvider.planet.name
    }
    
    var detailedDescription: String {
        return dataProvider.planet.description
    }
    
    init(dataProvider: DetailsDataProvider,
         uiDelegate: DetailsUIDelegate) {
        self.dataProvider = dataProvider
        self.uiDelegate = uiDelegate
    }
    
    private func voteFailed() {
        uiDelegate?.voteFailed()
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
