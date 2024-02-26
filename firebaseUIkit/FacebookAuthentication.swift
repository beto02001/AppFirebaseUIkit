//
//  FacebookAuthentication.swift
//  firebaseUIkit
//
//  Created by Luis Humberto on 26/02/24.
//

import Foundation
import FacebookLogin

class FacebookAuthentication {
    let loginManager = LoginManager()
    
    func loginFacebook(completionBlock: @escaping (Result<String, Error>) -> Void) {
        loginManager.logIn(permissions: ["email"], from: nil) { loginManagerResult, error in
            if let error = error {
                print("Hubo un error en autenticar con facebook: ", error.localizedDescription)
                completionBlock(.failure(error))
                return
            }
            let token = loginManagerResult?.token?.tokenString
            completionBlock(.success(token ?? "Token vacio"))
        }
    }
}
