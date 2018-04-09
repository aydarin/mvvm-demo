//
//  ListViewModel.swift
//  MVVMDemo
//
//  Created by Aydar Mukhametzyanov on 6/13/17.
//  Copyright © 2017 Aydar Mukhametzyanov. All rights reserved.
//

protocol ListUIDelegate: class {
    func didUpdateDataSource()
    
    func didStartLoading()
    func didFinishLoading()
}

class ListViewModel {
    
    private let dataProvider: ListDataProvider
    private let onSelect: (Planet) -> ()
    private weak var uiDelegate: ListUIDelegate?
    
    private(set) var dataSource: ListDataSource = EmptyListDataSourceImpl() {
        didSet {
            uiDelegate?.didUpdateDataSource()
        }
    }
    
    init(dataProvider: ListDataProvider, uiDelegate: ListUIDelegate, onSelect: @escaping (Planet) -> ()) {
        self.dataProvider = dataProvider
        self.uiDelegate = uiDelegate
        self.onSelect = onSelect
    }
    
    // MARK: - Actions
    
    func selectIndex(index: Int) {
        guard index < dataSource.planets.count else {
            return
        }
        
        onSelect(dataSource.planets[index])
    }
    
    func refresh() {
        uiDelegate?.didStartLoading()
        
        dataProvider.loadPlanets { [weak self] planets in
            self?.uiDelegate?.didFinishLoading()
            
            if planets.count > 0 {
                self?.dataSource = ListDataSourceImpl(planets: planets)
            } else {
                self?.dataSource = EmptyListDataSourceImpl()
            }
        }
    }
    
}
