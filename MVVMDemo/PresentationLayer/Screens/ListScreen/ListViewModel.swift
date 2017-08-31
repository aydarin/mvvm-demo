//
//  ListViewModel.swift
//  MVVMDemo
//
//  Created by Aydar Mukhametzyanov on 6/13/17.
//  Copyright © 2017 Aydar Mukhametzyanov. All rights reserved.
//

import RxSwift


protocol ListCoordinator: class {
    func list(_ viewModel: ListViewModel, didSelect planet: Planet)
}

class ListViewModel {
    
    private weak var coordinator: ListCoordinator?
    private let provider: ListProvider
    private let disposeBag = DisposeBag()
    
    let dataSourceObservable: Observable<ListDataSource>
    private let dataSourceVariable = Variable<ListDataSource>(EmptyListDataSourceImpl())
    
    let isLoading: Observable<Bool>
    private let isLoadingVariable = Variable<Bool>(false)
    
    
    init(provider: ListProvider, coordinator: ListCoordinator) {
        self.provider = provider
        self.coordinator = coordinator
        
        dataSourceObservable = dataSourceVariable.asObservable()
        isLoading = isLoadingVariable.asObservable()
    }
    
    // MARK: - Actions
    
    func selectIndex(index: Int) {
        coordinator?.list(self, didSelect: dataSourceVariable.value.planets[index])
    }
    
    func refresh() {
        isLoadingVariable.value = true
        
        provider.fetchPlanets().map { planets -> ListDataSource in
            return planets.count > 0
                ? ListDataSourceImpl(planets: planets)
                : EmptyListDataSourceImpl()
        }.do(onCompleted: { [weak self] in
            self?.isLoadingVariable.value = false
        }).bind(to: dataSourceVariable).disposed(by: disposeBag)
    }
    
}
