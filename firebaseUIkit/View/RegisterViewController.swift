//
//  RegisterViewController.swift
//  firebaseUIkit
//
//  Created by Luis Humberto on 21/02/24.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    var coordinator: MainCoordinator? = MainCoordinator()
    
    var autheticationViewModel: AuthenticationViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        autheticationViewModel?.delegate = self
    }
    
    deinit {
        coordinator = nil
    }
    
    @IBAction func registerUser(_ sender: UIButton) {
        autheticationViewModel?.createNewUser(email: tfEmail.text ?? "", password: tfPassword.text ?? "")
    }
}

extension RegisterViewController: createAndSignInProtocol {
    func errorCreate(messageError: String, titleError: ErrorTitle) {
        autheticationViewModel?.showAlertErrorMessage(viewController: self, titleError: titleError, messageError: messageError)
    }
    
    func succesfulCreate() {
        coordinator?.navigateToUserLoginView(navigationController: self.navigationController, viewModel: self.autheticationViewModel ?? AuthenticationViewModel())
    }
}
