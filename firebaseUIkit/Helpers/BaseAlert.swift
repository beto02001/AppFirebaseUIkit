//
//  BaseAlert.swift
//  firebaseUIkit
//
//  Created by Luis Humberto on 28/02/24.
//

import Foundation
import UIKit

class AlertView {
    static func showAlertErrorMessage(viewController: UIViewController, titleError: ErrorTitle, messageError: String) {
        let alertController = UIAlertController(title: titleError.rawValue, message: messageError, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cerrar", style: .cancel)
        alertController.addAction(cancelAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
}
