//
//  LinkDatasource.swift
//  firebaseUIkit
//
//  Created by Luis Humberto on 27/02/24.
//

import Foundation
import FirebaseFirestore


final class LinkDatasource {
    private let database = Firestore.firestore()
    private let collection = "links"
    
    func getAllLinks(completionBlock: @escaping (Result<[LinkModel], Error>) -> Void) {
        database.collection(collection).addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("error obtener todo los links: ", error.localizedDescription)
                completionBlock(.failure(error))
                return
            }
            
            guard let documents = querySnapshot?.documents.compactMap({ $0 }) else {
                print("Error compactMap: ")
                completionBlock(.success([]))
                return
            }
            let links = documents.map { try? $0.data(as: LinkModel.self) }.compactMap { $0 }
            completionBlock(.success(links))
        }
    }
    
    func createNewLink(linkModel: LinkModel, completionBlock: @escaping (Result<LinkModel, Error>)->Void) {
        do {
            _ = try database.collection(collection).addDocument(from: linkModel)
            completionBlock(.success(linkModel))
        } catch {
            completionBlock(.failure(error))
        }
    }
    
    func updateLink(link: LinkModel) {
        guard let document = link.id else { return }
        do {
            _ = try database.collection(collection).document(document).setData(from: link)
        } catch {
            print("Error actualizar documento")
        }
    }
    
    func deleteLink(link: LinkModel) {
        guard let document = link.id else { return }
        database.collection(collection).document(document).delete()
    }
}


