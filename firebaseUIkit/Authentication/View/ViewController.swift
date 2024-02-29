//
//  ViewController.swift
//  firebaseUIkit
//
//  Created by Luis Humberto on 21/02/24.
//

import UIKit

class ViewController: UIViewController {
    
    enum segueName {
        static let login = "mainToLogin"
        static let register = "mainToRegister"
    }

    var autheticationViewModel: AuthenticationViewModel = AuthenticationViewModel()
    var coordinator: MainCoordinator? = MainCoordinator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        autheticationViewModel.delegate = self
        if autheticationViewModel.user != nil {
            coordinator?.navigateToUserLoginView(navigationController: self.navigationController, viewModel: self.autheticationViewModel)
        }
    }

    deinit {
        coordinator = nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueName.login {
            coordinator?.navigateToLoginView(navigationController: self.navigationController, viewModel: autheticationViewModel, segue: segue)
        } else if segue.identifier == segueName.register {
            coordinator?.navigateToRegisterView(navigationController: self.navigationController, viewModel: autheticationViewModel, segue: segue)
        }
    }
    
    @IBAction func signInFacebook(_ sender: UIButton) {
        autheticationViewModel.loginUserFacebook()
    }
    
}

extension ViewController: createAndSignInProtocol {
    func errorCreate(messageError: String, titleError: ErrorTitle) {
        autheticationViewModel.showAlertErrorMessage(viewController: self, titleError: titleError, messageError: messageError)
    }
    
    func succesfulCreate() {
        coordinator?.navigateToUserLoginView(navigationController: self.navigationController, viewModel: self.autheticationViewModel)
    }
    
    
    
}
