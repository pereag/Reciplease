//
//  SearchViewController.swift
//  Reciplease
//
//  Created by Valc0d3 on 01/08/2022.
//

import UIKit

final class SearchViewController: UIViewController, UITextViewDelegate {
    
    var viewModel: SearchViewModel!
    
    private var items: [String] = []
    
    // MARK: Cycle Life
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        self.hideKeyboardWhenTappedAround()
        self.addButtonDoneOnUITextView()
        viewModel.viewDidLoad()
    }
    
    private func addButtonDoneOnUITextView() {
        let toolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0,  width: self.view.frame.size.width, height: 30))
        let flexSpace = UIBarButtonItem(barButtonSystemItem:    .flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissMyKeyboard))
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()
        self.addElementField.inputAccessoryView = toolbar
    }
    
    @objc func dismissMyKeyboard() {
        view.endEditing(true)
    }
    
    private func bindViewModel() {
        viewModel.items = { [weak self] items in
            DispatchQueue.main.async {
                self?.items = items
                self?.tableView.reloadData()
            }
        }
        
        viewModel.titleText = { [weak self] titleText in
            self?.titleLabel.text = titleText
        }
        
        viewModel.searchPlaceholderText = { [weak self] searchPlaceholderText in
            self?.addElementField.placeholder = searchPlaceholderText
        }
        
        viewModel.subtitleText = { [weak self] subtitleText in
            self?.ingredientsLabel.text = subtitleText
        }
        
        viewModel.addButtonText = { [weak self] addButtonText in
            self?.addButton.setTitle(addButtonText, for: .normal)
        }
        
        viewModel.clearButtonText = { [weak self] clearButtonText in
            self?.clearButton.setTitle(clearButtonText, for: .normal)
        }
        
        viewModel.searchButtontext = { [weak self] searchButtontext in
            self?.searchButton.setTitle(searchButtontext, for: .normal)
        }
        
        viewModel.displayedAlert = { [weak self] alertContent in
            DispatchQueue.main.async {
                self?.presentAlert(content: alertContent)
            }
        }
    }
    
    // MARK: Input
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var addElementField: UITextField!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var addButton: UIButton!
    @IBOutlet private weak var ingredientsLabel: UILabel!
    @IBOutlet private weak var clearButton: UIButton!
    @IBOutlet private weak var searchButton: UIButton!
    
    // MARK: output
    
    var displayedAlert: ((AlertContent) -> Void)?
    
    @IBAction private func didPressSearch(_ sender: Any) {
        viewModel.didPressSearch()
    }
    
    @IBAction private func didPressAdd(_ sender: Any) {
        viewModel.didPressAdd(item: addElementField.text!)
    }
    
    @IBAction private func didPressClear(_ sender: UIButton) {
        viewModel.didPressClear()
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = items[indexPath.item]
        return cell
    }
}
