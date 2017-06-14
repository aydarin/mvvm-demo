//
//  ListViewModel.swift
//  MVVMDemo
//
//  Created by Aydar Mukhametzyanov on 6/13/17.
//  Copyright © 2017 Aydar Mukhametzyanov. All rights reserved.
//

protocol ListViewModel {
    var dataSource: ListDataSource { get }
    
    var uiDelegate: ListUIDelegate? { get set }
    
    func refresh()
    func selectIndex(index: Int)
}

protocol ListUIDelegate: class {
    func didUpdateDataSource()
    
    func didStartLoading()
    func didFinishLoading()
}

protocol ListCoordinator: class {
    func list(_ viewModel: ListViewModel, selectedPlanet planet: Planet)
}

class ListViewModelImpl: ListViewModel {
    
    weak var uiDelegate: ListUIDelegate?
    weak var coordinator: ListCoordinator?
    
    private(set) var dataSource: ListDataSource = EmptyListDataSourceImpl() {
        didSet {
            uiDelegate?.didUpdateDataSource()
        }
    }
    
    private let model: ListModel
    
    init(model: ListModel) {
        self.model = model
    }
    
    // MARK: - Actions
    
    func selectIndex(index: Int) {
        coordinator?.list(self, selectedPlanet: dataSource.planets[index])
    }
    
    func refresh() {
        uiDelegate?.didStartLoading()
        
        model.loadPlanets { [weak self] planets in
            self?.uiDelegate?.didFinishLoading()
            
            if planets.count > 0 {
                self?.dataSource = ListDataSourceImpl(planets: planets)
            } else {
                self?.dataSource = EmptyListDataSourceImpl()
            }
        }
    }
    
}
