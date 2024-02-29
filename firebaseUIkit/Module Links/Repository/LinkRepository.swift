//
//  LinkRepository.swift
//  firebaseUIkit
//
//  Created by Luis Humberto on 27/02/24.
//

import Foundation

final class LinkRepository {
    
    private let linkDatasource: LinkDatasource
    private let metadataDatasource: MetadataDatasource
    
    init(linkDatasource: LinkDatasource = LinkDatasource(), metadataDatasource: MetadataDatasource = MetadataDatasource()) {
        self.linkDatasource = linkDatasource
        self.metadataDatasource = metadataDatasource
    }
    
    func getAllLinks(completionBlock: @escaping (Result<[LinkModel], Error>) -> Void) {
        linkDatasource.getAllLinks(completionBlock: completionBlock)
    }
    
    func createNewLink(url: String, completionBlock: @escaping (Result<LinkModel, Error>) -> Void) {        
        metadataDatasource.getMetadata(fromURL: url) { [weak self]result in
            switch result {
            case .success(let linkModelResult):
                self?.linkDatasource.createNewLink(linkModel: linkModelResult, completionBlock: completionBlock)
            case .failure(let error):
                completionBlock(.failure(error))
            }
        }
    }
    
    func upadteLink(link: LinkModel) {
        linkDatasource.updateLink(link: link)
    }
    
    func deleteLink(link: LinkModel) {
        linkDatasource.deleteLink(link: link)
    }
}
