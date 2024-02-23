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
    func errorCreate(messageError: String) {
        let alertController = UIAlertController(title: "Erro al crear usuario", message: messageError, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cerrar", style: .cancel)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion:nil)
    }
    
    func succesfulCreate() {
        coordinator?.navigateToUserLoginView(navigationController: self.navigationController, viewModel: self.autheticationViewModel ?? AuthenticationViewModel())
    }
}
