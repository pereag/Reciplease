//
//  RecipeViewDataSources.swift
//  Reciplease
//
//  Created by Valc0d3 on 28/09/2022.
//

import UIKit

final class RecipeListViewDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var viewModel: RecipeListViewModel!
    var items: [Recipe] = []
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard items.indices.contains(indexPath.row) else { return .init() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as! ItemTableViewCell
        
        cell.configure(recipe: items[indexPath.row], viewModel: self.viewModel, index: indexPath)
        return cell
    }
}