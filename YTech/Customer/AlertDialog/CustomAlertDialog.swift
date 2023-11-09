//
//  CustomAlertDialog.swift
//  YTech
//
//  Created by Muhammet  on 8.11.2023.
//

import UIKit

class CustomAlertDialog {
    static func showAlert(from viewController: UIViewController, withTitle title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
}
