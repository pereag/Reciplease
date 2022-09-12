//
//  SearchViewController.swift
//  Reciplease
//
//  Created by Valc0d3 on 01/08/2022.
//

import UIKit

final class SearchViewController: UIViewController {
    
    var viewModel: SearchViewModel!

    private var items: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        bindViewModel()
    }

    private func bindViewModel() {
        viewModel.items = { [weak self] items in
            DispatchQueue.main.async {
                self?.items = items
                self?.tableView.reloadData()
            }
        }
    }
    
    // MARK: Input

    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var addElementField: UITextField!
    
    // MARK: output

    @IBAction private func didPressSearch(_ sender: Any) {
        viewModel.didPressSearch()
    }
    
    @IBAction private func didPressAdd(_ sender: Any) {
        if addElementField.text != "" {
            viewModel.didPressAdd(item: addElementField.text!)
            addElementField.text = ""
        }
    }
    
    @IBAction private func didPressClear(_ sender: UIButton) {
        viewModel.didPressClear()
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = items[indexPath.item]
        return cell
    }
}
