//
//  RecipeViewController.swift
//  Reciplease
//
//  Created by Valc0d3 on 01/08/2022.
//

import UIKit

final class RecipeListViewController: UIViewController {
    
    var viewModel: RecipeListViewModel!
    private let dataSource = RecipeListViewDataSource()
    
    // MARK: Input
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Output
    
    // MARK: - View life cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewDidLoad()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        bindDataSource()

        tableView.dataSource = dataSource
        tableView.delegate = dataSource
    }
    
    private func bindViewModel() {
        viewModel.items = { [weak self] items in
            self?.dataSource.update(items: items)
            self?.tableView.reloadData()
        }
        viewModel.displayedAlert = { [weak self] alertContent in
            DispatchQueue.main.async {
                self?.presentAlert(content: alertContent)
            }
        }
    }

    private func bindDataSource() {
//        dataSource.didSelectItemAt = { index in
//            viewModel.didPressItem(at: index)
//        }
        dataSource.didSelectItemAt = viewModel.didPressItem
    }
}
