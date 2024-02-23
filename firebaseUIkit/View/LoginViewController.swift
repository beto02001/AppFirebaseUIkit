//
//  LoginViewController.swift
//  firebaseUIkit
//
//  Created by Luis Humberto on 21/02/24.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var tfCorreo: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    var autheticationViewModel: AuthenticationViewModel?
    var coordinator: MainCoordinator? = MainCoordinator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        autheticationViewModel?.delegate = self
        // Do any additional setup after loading the view.
    }
    
    deinit {
        coordinator = nil
    }

    @IBAction func loginUser(_ sender: UIButton) {
        autheticationViewModel?.loginUser(email: tfCorreo.text ?? "", password: tfPassword.text ?? "")
    }
}

extension LoginViewController: createAndSignInProtocol {
    
    func errorCreate(messageError: String) {
        let alertController = UIAlertController(title: "Error al iniciar sesión", message: messageError, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cerrar", style: .cancel)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion:nil)
    }
    
    func succesfulCreate() {
        coordinator?.navigateToUserLoginView(navigationController: self.navigationController, viewModel: self.autheticationViewModel ?? AuthenticationViewModel())
    }
}
