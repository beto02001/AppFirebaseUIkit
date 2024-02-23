//
//  AuthenticationRepository.swift
//  firebaseUIkit
//
//  Created by Luis Humberto on 21/02/24.
//

import Foundation

class AuthenticationRepository {
    private let authenticationFirebaseDataSource: AuthenticationFirebaseDataSource
    
    init(authenticationFirebaseDataSource: AuthenticationFirebaseDataSource = AuthenticationFirebaseDataSource()) {
        self.authenticationFirebaseDataSource = authenticationFirebaseDataSource
    }
    
    func getCurrentUser() -> User? {
        return authenticationFirebaseDataSource.getCurrentUser()
    }
    
    func createNewUser(email: String, password: String, completionBlock: @escaping (Result<User, Error>) -> Void) {
        authenticationFirebaseDataSource.createNewUsers(email: email, password: password, completionBlock: completionBlock)
    }
    
    func loginUser(email: String, password: String, completionBlock: @escaping (Result<User, Error>) -> Void) {
        authenticationFirebaseDataSource.loginUser(email: email, password: password, completionBlock: completionBlock)
    }
    
    func logout() throws {
       try authenticationFirebaseDataSource.logout()
    }
}
