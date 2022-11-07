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
    private var getDirectionButtonUrl: String = ""
    private var ingredientLines: [String] = []
    private var favorite: Bool = false
    
    // MARK: Inputs
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var getDirectionButton: UIButton!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var dishImage: UIImageView!
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var gradienBackgroundView: GradientView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var subTitle: UILabel!
    
    // MARK: Cycle Life
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTimeViewStyle()
        configure(to: viewModel)
        tableView.dataSource = self
        addFavoriteStyle()
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
            self?.subTitle.text = currentRecipe.ingredientLines.joined(separator: " ,")
            
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
            self?.ingredientLines = currentRecipe.ingredientLines
        }
        
        viewModel.heartsState = { [weak self] heartsState in
            self?.favorite = heartsState
            self?.addFavoriteStyle()
        }
        setGradientBackground()
        
    }
    
    private func addFavoriteStyle() {
        if favorite == false {
            self.navigationItem.rightBarButtonItem = .init(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(didPressFavorite))
        } else {
            self.navigationItem.rightBarButtonItem = .init(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: #selector(didPressFavorite))
        }
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
    
    @objc private func didPressFavorite() {
        favorite = viewModel.didPressFavorite()
        addFavoriteStyle()
    }
    
    // MARK:  Outputs
    
    @IBAction func didPressGetDirections(_ sender: Any) {
        UIApplication.shared.open(URL(string: self.getDirectionButtonUrl)!)
    }
}

extension DetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ingredientLines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text =  "- " + self.ingredientLines[indexPath.item]
        return cell
    }
}

