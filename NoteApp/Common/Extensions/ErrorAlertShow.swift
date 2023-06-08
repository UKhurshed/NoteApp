//
//  ErrorAlertShow.swift
//  NoteApp
//
//  Created by Khurshed Umarov on 08.06.2023.
//

import UIKit

extension UIViewController {
    func presentAlertError(title: String, message: String, actionStr: String) {
        print("error message: \(message)")
        DispatchQueue.main.async {
            let alert  = UIAlertController(
                title: R.string.localizable.titleErrorLabel(),
                message: message,
                preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(
                title: R.string.localizable.alertDismiss(),
                style: .cancel,
                handler: nil))
            
            self.present(alert, animated: true)
        }
    }
}
