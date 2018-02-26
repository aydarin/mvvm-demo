//
//  ListViewModel.swift
//  MVVMDemo
//
//  Created by Aydar Mukhametzyanov on 6/13/17.
//  Copyright © 2017 Aydar Mukhametzyanov. All rights reserved.
//

protocol ListViewModel {
    var dataSource: ListDataSource { get }
    
    func refresh()
    func selectIndex(index: Int)
}

protocol ListUIDelegate: class {
    func didUpdateDataSource()
    
    func didStartLoading()
    func didFinishLoading()
}

class ListViewModelImpl: ListViewModel {
    
    private let provider: ListProvider
    private let onSelect: (Planet) -> ()
    private weak var uiDelegate: ListUIDelegate?
    
    private(set) var dataSource: ListDataSource = EmptyListDataSourceImpl() {
        didSet {
            uiDelegate?.didUpdateDataSource()
        }
    }
    
    init(provider: ListProvider, uiDelegate: ListUIDelegate, onSelect: @escaping (Planet) -> ()) {
        self.provider = provider
        self.uiDelegate = uiDelegate
        self.onSelect = onSelect
    }
    
    // MARK: - Actions
    
    func selectIndex(index: Int) {
        onSelect(dataSource.planets[index])
    }
    
    func refresh() {
        uiDelegate?.didStartLoading()
        
        provider.loadPlanets { [weak self] planets in
            self?.uiDelegate?.didFinishLoading()
            
            if planets.count > 0 {
                self?.dataSource = ListDataSourceImpl(planets: planets)
            } else {
                self?.dataSource = EmptyListDataSourceImpl()
            }
        }
    }
    
}
