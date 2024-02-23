//
//  Coordinator.swift
//  firebaseUIkit
//
//  Created by Luis Humberto on 21/02/24.
//

import Foundation
import UIKit

protocol Coordinator {
    func navigateToUserLoginView(navigationController: UINavigationController?, viewModel: AuthenticationViewModel)
    func navigateToLoginView(navigationController: UINavigationController?, viewModel: AuthenticationViewModel, segue: UIStoryboardSegue)
    func navigateToRegisterView(navigationController: UINavigationController?, viewModel: AuthenticationViewModel, segue: UIStoryboardSegue)
}


class MainCoordinator: Coordinator {

    func navigateToUserLoginView(navigationController: UINavigationController?, viewModel: AuthenticationViewModel) {
        let storyboard = UIStoryboard(name: "UserLoged", bundle: nil)
        guard let controller = storyboard.instantiateViewController(identifier: "UserLogedSB") as? UserLogedViewController else { return }
        controller.autheticationViewModel = viewModel
        navigationController?.popViewController(animated: false)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func navigateToLoginView(navigationController: UINavigationController?, viewModel: AuthenticationViewModel, segue: UIStoryboardSegue) {
        let viewController = segue.destination as! LoginViewController
        viewController.autheticationViewModel = viewModel
    }
    
    func navigateToRegisterView(navigationController: UINavigationController?, viewModel: AuthenticationViewModel, segue: UIStoryboardSegue) {
        let viewController = segue.destination as! RegisterViewController
        viewController.autheticationViewModel = viewModel
    }
}

