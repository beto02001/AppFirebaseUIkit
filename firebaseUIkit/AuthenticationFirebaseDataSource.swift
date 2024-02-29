//
//  AuthenticationFirebaseDataSource.swift
//  firebaseUIkit
//
//  Created by Luis Humberto on 21/02/24.
//

import Foundation
import FirebaseAuth
import FacebookLogin

final class AuthenticationFirebaseDataSource {
    private let facebookLAuthentication = FacebookAuthentication()
    
    //--------------------------------------------------------------------------
    // MARK: Métodos para ingreso con correo electrónico
    //--------------------------------------------------------------------------
    func getCurrentUser() -> User? {
        guard let email = Auth.auth().currentUser?.email else { return .none }
        return .init(email: email)
    }
    
    func createNewUsers(email: String, password: String, completionBlock: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authDataResult, error in
            if let error = error  {
                print("Error al crear un nuevo usuario: ", error.localizedDescription)
                completionBlock(.failure(error))
                return
            }
            let email = authDataResult?.user.email ?? "no hay email"
            print("Nuevo usuario creado: ", email)
            completionBlock(.success(.init(email: email)))
        }
    }
    
    
    func loginUser(email: String, password: String, completionBlock: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authDataResult, error in
            if let error = error {
                print("No se puedo iniciar sesión: ", error.localizedDescription)
                completionBlock(.failure(error))
            }
            let email = authDataResult?.user.email ?? "no hay email"
            completionBlock(.success(.init(email: email)))
        }
    }
    
    //--------------------------------------------------------------------------
    // MARK: Métodos para ingreso con correo electrónico
    //--------------------------------------------------------------------------
    func loginUserFacebook(completionBlock: @escaping (Result<User, Error>) -> Void) {
        facebookLAuthentication.loginFacebook { result in
            switch result {
            case .success(let accesToken):
                let credential = FacebookAuthProvider.credential(withAccessToken: accesToken)
                Auth.auth().signIn(with: credential) { authDataResult, error in
                    if let error = error {
                        print("Error crear un usuario: ", error.localizedDescription)
                        completionBlock(.failure(error))
                        return
                    }
                    let email = authDataResult?.user.email ?? "No email"
                    print("user creado", email)
                    completionBlock(.success(.init(email: email)))
                }
                
            case .failure(let error):
                print("Error signIn with facebook: ", error.localizedDescription)
                completionBlock(.failure(error))
                return
            }
        }
    }
    
    //--------------------------------------------------------------------------
    // MARK: Métodos salid de sesión
    //--------------------------------------------------------------------------
    func logout() throws {
        try Auth.auth().signOut()
    }
    

}
