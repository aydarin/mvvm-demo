//
//  DetailsViewController.swift
//  MVVMDemo
//
//  Created by Aydar Mukhametzyanov on 6/12/17.
//  Copyright © 2017 Aydar Mukhametzyanov. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var viewModel: DetailsViewModel!
    
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet fileprivate weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = viewModel.title
        descriptionLabel.text = viewModel.detailedDescription
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Vote", style: .plain, target: self, action: #selector(votePressed))
        
    }
    
    // MARK: - Actions
    
    @objc private func votePressed() {
        viewModel.votePressed()
    }
    
    // MARK: - Utils
    
    static func createStoryboardsInstance() -> DetailsViewController {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
            .instantiateViewController(withIdentifier: "detailsScreen") as! DetailsViewController
    }

}

extension DetailsViewController: DetailsUIDelegate {
    
    func voteSucceded() {
        let alertVC = UIAlertController(title: "Thanks!", message: "Successfully voted", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    func voteFailed() {
        let alertVC = UIAlertController(title: "Voting failed", message: "Authentication error", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    func didStartLoading() {
        activityIndicator.startAnimating()
    }
    
    func didFinishLoading() {
        activityIndicator.stopAnimating()
    }
    
}
