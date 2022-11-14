//
//  File.swift
//  Reciplease
//
//  Created by Valc0d3 on 29/09/2022.
//

import UIKit
import AlamofireImage

final class ItemTableViewCell: UITableViewCell {
    //MARK: Input
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var ingredientsLabel: UILabel!
    @IBOutlet private weak var dishImage: UIImageView!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var timeView: UIView!
    @IBOutlet private weak var gradienBackgroundView: GradientView!
    
    // MARK: Cycle Life
    
    func configure(recipe: Recipe) {
        DispatchQueue.main.async {
            self.setGradientBackground()
        }
        titleLabel.text = recipe.name
        ingredientsLabel.text = recipe.ingredientLines.joined(separator: ", ")
        
        if let url = URL(string: recipe.image) {
            dishImage.af.setImage(withURL: url)
            dishImage.contentMode = .scaleAspectFill
        }
        
        timeView.layer.cornerRadius = 5;
        timeView.layer.borderWidth = 2;
        timeView.layer.borderColor = UIColor.white.cgColor;
        
        if recipe.totalTime == 0.0 {
            timeView.alpha = 0
        } else {
            timeView.alpha = 1
            timeLabel.text = String(recipe.totalTime) + " min"
        }
    }
    
    private func setGradientBackground() {
        let startColor = UIColor.clear
        let endColor = UIColor.black
        gradienBackgroundView.updateGradient(with: .vertical, colors: startColor, endColor)
    }
}
