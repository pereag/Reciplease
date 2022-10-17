//
//  DetailsViewController.swift
//  Reciplease
//
//  Created by Valc0d3 on 03/10/2022.
//

import UIKit
import SwiftUI

class DetailsViewController: UIViewController {
    
    // MARK: Properties
    
    var viewModel: DetailsViewModel!
    
    // MARK: Inputs
    
    @IBOutlet weak var detailsImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var getDirectionButton: UIButton!
    
    // MARK: Cycle Life
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = .init(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: nil)
        viewModel.viewDidLoad()
    }
    
    func configure(recipe: Recipe, indredientsLabelText: String, buttonLabel: String) {
        titleLabel.text = recipe.name
        ingredientsLabel.text = indredientsLabelText
        getDirectionButton.setTitle(buttonLabel, for: .normal)
    }
    
    // MARK:  Outputs
    
    @IBAction func didPressGetDirections(_ sender: Any) {
        
    }
    
    
    
}
