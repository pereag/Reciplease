//
//  File.swift
//  Reciplease
//
//  Created by Valc0d3 on 29/09/2022.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var dishImage: UIImageView!

    func configure(recipe: Recipe) {
        TitleLabel.text = recipe.name
        // ingredientsLabel = recipe.ingredientLines
        //dishImage = recipe.image
    }
}
