//
//  UIViewManager.swift
//  Reciplease
//
//  Created by Valc0d3 on 19/09/2022.
//

import UIKit

extension UIViewController {
    func presentAlert(content: AlertContent) {
        let alertVC = UIAlertController( title: content.title, message: content.message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: content.cancelTitle, style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}
