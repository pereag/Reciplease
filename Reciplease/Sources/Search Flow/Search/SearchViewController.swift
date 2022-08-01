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

    @IBAction private func didPressSearch(_ sender: Any) {
        viewModel.didPressSearch()
    }
}
