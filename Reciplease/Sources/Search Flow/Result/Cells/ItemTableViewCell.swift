//
//  File.swift
//  Reciplease
//
//  Created by Valc0d3 on 29/09/2022.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var dishImage: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeView: UIView!
    @IBOutlet var gradienBackgroundView: UIView!
    
    func configure(recipe: Recipe) {
        titleLabel.text = recipe.name
        ingredientsLabel.text = recipe.ingredientLines.joined(separator: " ,")
        dishImage.load(url:recipe.image)
        setGradientBackground(view: self.gradienBackgroundView)
        if recipe.totalTime == 0.0 {
            timeView.alpha = 0
        } else {
            timeView.alpha = 1
            timeLabel.text = String(recipe.totalTime) + " min"
        }
    }
    
    func setGradientBackground(view: UIView) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.white.withAlphaComponent(0.5)]
        gradientLayer.startPoint = CGPoint(x : 0.5, y : 1.0)
        gradientLayer.endPoint = CGPoint(x : 0.5, y : 0.0)
        gradientLayer.locations = [ 0,1]
        gradientLayer.frame = self.frame
        view.layer.insertSublayer(gradientLayer, at : 0)
      }
    
    
}
extension UIImageView {
    func load(url: String) {
        let url = URL(string: url)
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url!) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
        self.contentMode = .scaleAspectFill
    }
}
