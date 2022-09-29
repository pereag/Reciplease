//
//  RecipeViewDataSources.swift
//  Reciplease
//
//  Created by Valc0d3 on 28/09/2022.
//

import UIKit

final class RecipeViewDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var items: [RecipeResponse.Hit] = [] {
        didSet {
            print(self.items)
            
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as! ItemTableViewCell
        cell.TitleLabel.text = "yolo"
        return cell
    }
    
    
    /* func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "yolo"
        return cell
    } */
   
}
