//
//  AuthenticationViewModel.swift
//  firebaseUIkit
//
//  Created by Luis Humberto on 21/02/24.
//

import Foundation

protocol createAndSignInProtocol: AnyObject {
    func errorCreate(messageError: String)
    func succesfulCreate()
}

protocol UserLoginProtocol: AnyObject {
    func goToViewUserLoger()
}

final class AuthenticationViewModel {
    
    var user: User?
    var messageError: String?
    weak var delegate: createAndSignInProtocol?
    weak var delegateUserLoged: UserLoginProtocol?
    
    private let authenticatorRepository: AuthenticationRepository
    
    init(authenticatorRepository: AuthenticationRepository = AuthenticationRepository()) {
        self.authenticatorRepository = authenticatorRepository
        getCurrentUser()
    }

    func getCurrentUser() {
        self.user = authenticatorRepository.getCurrentUser()
    }
    
    func createNewUser(email: String, password: String) {
        authenticatorRepository.createNewUser(email: email, password: password) { [weak self] result in
            switch result {
            case .success(let user):
                self?.user = user
                self?.delegate?.succesfulCreate()
            case .failure(let error):
                self?.messageError = error.localizedDescription
                self?.delegate?.errorCreate(messageError: self?.messageError ?? "No se puedo encontrar el error")
            }
        }
    }
    
    func loginUser(email: String, password: String) {
        authenticatorRepository.loginUser(email: email, password: password) { [weak self] result in
            switch result {
            case .success(let user):
                self?.user = user
                self?.delegate?.succesfulCreate()
            case .failure(let error):
                self?.messageError = error.localizedDescription
                self?.delegate?.errorCreate(messageError: self?.messageError ?? "No se puedo encontrar el error")
            }
        }
    }
    
    func logout() throws {
        do {
            try authenticatorRepository.logout()
            self.user = nil
        } catch {
            print("Hubo un error")
        }
        
    }
}
