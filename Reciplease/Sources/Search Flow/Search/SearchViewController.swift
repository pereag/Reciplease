//
//  SearchViewController.swift
//  Reciplease
//
//  Created by Valc0d3 on 01/08/2022.
//

import UIKit

final class SearchViewController: UIViewController {
    
    var viewModel: SearchViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Input

    @IBOutlet private weak var addElementField: UITextField!
    @IBOutlet private weak var ingredientsTableView: UITableView!
    
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
