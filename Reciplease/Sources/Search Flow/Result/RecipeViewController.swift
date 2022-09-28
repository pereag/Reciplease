//
//  RecipeViewController.swift
//  Reciplease
//
//  Created by Valc0d3 on 01/08/2022.
//

import UIKit

final class RecipeViewController: UIViewController {
    
    var viewModel: RecipeViewModel!
   // private let dataSource = RecipeViewDataSource()
    
    private var items: [String] = ["troute", "yolo", "splash"]
    
    // MARK: Input
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Output
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.dataSource = dataSource
        //tableView.delegate = dataSource

        //bind(to: dataSource)
        //bind(to: viewModel)

        viewModel.viewDidLoad()
    }

   //private func bind(to source: RecipeViewDataSource) {
       
   //}
    
    //private func bind(to: RecipeViewModel) {

    //}
}

extension RecipeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3 // items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = items[indexPath.item]
        return cell
    }
}
