//
//  AuthenticationFirebaseDataSource.swift
//  firebaseUIkit
//
//  Created by Luis Humberto on 21/02/24.
//

import Foundation
import FirebaseAuth

struct User {
    let email: String
}


final class AuthenticationFirebaseDataSource {
    
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
    
    func logout() throws {
        try Auth.auth().signOut()
    }
}
