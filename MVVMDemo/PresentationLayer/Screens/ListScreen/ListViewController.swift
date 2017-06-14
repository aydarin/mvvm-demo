//
//  ListViewController.swift
//  MVVMDemo
//
//  Created by Aydar Mukhametzyanov on 6/13/17.
//  Copyright © 2017 Aydar Mukhametzyanov. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    var viewModel: ListViewModel! {
        didSet {
            viewModel.uiDelegate = self
        }
    }
    
    @IBOutlet fileprivate weak var tableView: UITableView!
    @IBOutlet fileprivate weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Planets"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Refresh", style: .plain, target: self, action: #selector(refreshPressed))
        
        reloadTable()
    }
    
    fileprivate func reloadTable() {
        tableView.dataSource = viewModel.dataSource
        tableView.reloadData()
    }
    
    // MARK: - Actions
    
    @objc private func refreshPressed() {
        viewModel.refresh()
    }

}

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectIndex(index: indexPath.row)
    }
    
}

extension ListViewController: ListUIDelegate {
    
    func didUpdateDataSource() {
        reloadTable()
    }
    
    func didStartLoading() {
        activityIndicator.startAnimating()
    }
    
    func didFinishLoading() {
        activityIndicator.stopAnimating()
    }
    
}
