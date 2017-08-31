//
//  ListViewController.swift
//  MVVMDemo
//
//  Created by Aydar Mukhametzyanov on 6/13/17.
//  Copyright © 2017 Aydar Mukhametzyanov. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ListViewController: UIViewController {
    
    var viewModel: ListViewModel!
    private let disposeBag = DisposeBag()
    
    @IBOutlet fileprivate weak var tableView: UITableView!
    @IBOutlet fileprivate weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Planets"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Refresh", style: .plain, target: self, action: #selector(refreshPressed))
        
        tableView.delegate = self
        
        viewModel.dataSourceObservable.subscribe(onNext: { [weak self] dataSource in
            self?.tableView.dataSource = dataSource
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        viewModel.isLoading.bind(to: activityIndicator.rx.isAnimating).disposed(by: disposeBag)
    }
    
    // MARK: - Actions
    
    @objc private func refreshPressed() {
        viewModel.refresh()
    }
    
    // MARK: - Utils
    
    static func createStoryboardsInstance() -> ListViewController {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
            .instantiateViewController(withIdentifier: "listScreen") as! ListViewController
    }

}

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.selectIndex(index: indexPath.row)
    }
    
}
