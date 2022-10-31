//
//  DetailsViewController.swift
//  Reciplease
//
//  Created by Valc0d3 on 03/10/2022.
//

import UIKit
import AlamofireImage

class DetailsViewController: UIViewController {
    
    // MARK: Properties
    
    var viewModel: DetailsViewModel!
    var getDirectionButtonUrl: String = ""
    
    // MARK: Inputs
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var getDirectionButton: UIButton!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var dishImage: UIImageView!
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var gradienBackgroundView: GradientView!
    
    // MARK: Cycle Life
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTimeViewStyle()
        configure(to: viewModel)
        self.navigationItem.rightBarButtonItem = .init(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: nil)
        viewModel.viewDidLoad()
    }
    
    private func configure(to: DetailsViewModel) {
        viewModel.ingredientsTitle = { [weak self] ingredientsTitle in
            self?.ingredientsLabel.text = ingredientsTitle
        }
        
        viewModel.buttonLabel = { [weak self] buttonLabel in
            self?.getDirectionButton.setTitle(buttonLabel, for: .normal)
        }
        
        viewModel.currentRecipe = { [weak self] currentRecipe in
            self?.titleLabel.text = currentRecipe.name
            self?.durationLabel.text = String(currentRecipe.totalTime)
            self?.getDirectionButtonUrl = currentRecipe.url
            
            if currentRecipe.totalTime == 0.0 {
                self?.timeView.alpha = 0
            } else {
                self?.timeView.alpha = 1
                self?.durationLabel.text = String(currentRecipe.totalTime) + " min"
            }
            
            if self?.getDirectionButtonUrl == "" {
                self?.getDirectionButton.alpha = 0
            }
            
            if let url = URL(string: currentRecipe.image) {
                self?.dishImage.af.setImage(withURL: url)
                self?.dishImage.contentMode = .scaleAspectFill
            }
        }
        setGradientBackground()
        
    }
    
    private func addTimeViewStyle() {
        timeView.layer.cornerRadius = 5;
        timeView.layer.borderWidth = 2;
        timeView.layer.borderColor = UIColor.white.cgColor;
    }
    
    private func setGradientBackground() {
        let startColor = UIColor.clear
        let endColor = UIColor.black
        gradienBackgroundView.updateGradient(with: .vertical, colors: startColor, endColor)
    }
    
    // MARK:  Outputs
    
    @IBAction func didPressGetDirections(_ sender: Any) {
        UIApplication.shared.open(URL(string: self.getDirectionButtonUrl)!)
    }
}

