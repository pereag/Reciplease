//
//  RecipeViewController.swift
//  Reciplease
//
//  Created by Valc0d3 on 01/08/2022.
//

import UIKit

final class RecipeViewController: UIViewController {
    
    var viewModel: RecipeViewModel!
    private let dataSource = RecipeViewDataSource()
    
    // MARK: Input
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Output
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(to: viewModel)
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        viewModel.viewDidLoad()
    }
    
    private func bind(to: RecipeViewModel) {
        viewModel.items = { [weak self] items in
            self?.dataSource.items = items
            self?.dataSource.viewModel = self?.viewModel
            self?.tableView.reloadData()
        }
    }
    
    private func didPressDetailsButtonCellView() {
        viewModel.didPressDetailsButtonCellView(index: 1)
    }
}
