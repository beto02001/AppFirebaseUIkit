//
//  UserLogedViewController.swift
//  firebaseUIkit
//
//  Created by Luis Humberto on 22/02/24.
//

import UIKit

class UserLogedViewController: UIViewController {
    
    
    var autheticationViewModel: AuthenticationViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    
    @IBAction func actionLogout(_ sender: UIButton) {
        logoutSession()
    }
    
    func logoutSession() {
        do {
            try autheticationViewModel?.logout()
            navigationController?.popViewController(animated: true)
        } catch {
            print("Error")
        }
    }
}
