//
//  MetadataDatasource.swift
//  firebaseUIkit
//
//  Created by Luis Humberto on 28/02/24.
//

import Foundation
import LinkPresentation

enum CustomMetadataError: Error {
    case badURl
}

final class MetadataDatasource {
    
    private var metadataProvaider: LPMetadataProvider? = nil
    
    func getMetadata(fromURL url: String, completionBlock: @escaping (Result<LinkModel, Error>) -> Void) {
        guard let url = URL(string: url) else {
            completionBlock(.failure(CustomMetadataError.badURl))
            return
        }
        
        metadataProvaider = LPMetadataProvider()
        metadataProvaider?.startFetchingMetadata(for: url, completionHandler: { metadata, error in
            if let error = error {
                print("Error en revisar la Metadata: ", error.localizedDescription)
                completionBlock(.failure(error))
                return
            }
            let linkModel = LinkModel(url: url.absoluteString, title: metadata?.title ?? "No title", isFavorited: false, isCompleted: false)
            completionBlock(.success(linkModel))
        })
        
    }
    
}
