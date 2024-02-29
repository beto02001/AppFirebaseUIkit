//
//  LinkViewModel.swift
//  firebaseUIkit
//
//  Created by Luis Humberto on 27/02/24.
//

import Foundation
import UIKit

class LinkViewModel {
    var linksModel: [LinkModel] = []
    var messageError: String?
    var delegateInfoTable: InformationDataTable?
    
    private let linkRepository: LinkRepository
    
    init(linkRepository: LinkRepository = LinkRepository()) {
        self.linkRepository = linkRepository
    }
    
    func getAllLinks() {
        linkRepository.getAllLinks { [weak self] result in
            switch result {
            case .success(let linkModels):
                //TODO
                self?.linksModel = linkModels
                self?.delegateInfoTable?.successfulInfo(links: linkModels)
            case .failure(let error):
                //TODO
                print("Ocurrio error en links: ", self?.messageError ?? "no tiene mensaje")
                self?.messageError = error.localizedDescription
            }
        }
    }
    
    func createNewLink(url: String) {
        linkRepository.createNewLink(url: url) { [weak self] result in
            switch result {
            case .success(let link):
                self?.delegateInfoTable?.successfulInfo(links: self?.linksModel ?? [LinkModel]())
            case .failure(let error):
                self?.delegateInfoTable?.errorCreateLink(error: error.localizedDescription)
                self?.messageError = error.localizedDescription
            }
        }
    }
    
    func updateIsFavorited(link: LinkModel) {
        let updateFavorited = LinkModel(id: link.id ?? "No ID",
                                       url: link.url,
                                       title: link.url,
                                       isFavorited: !link.isFavorited,
                                       isCompleted: link.isCompleted)
        linkRepository.upadteLink(link: updateFavorited)
    }
    
    func updateIsComplete(link: LinkModel) {
        let updateComplete = LinkModel(id: link.id ?? "No ID",
                                       url: link.url,
                                       title: link.url,
                                       isFavorited: link.isFavorited,
                                       isCompleted: !link.isCompleted)
        linkRepository.upadteLink(link: updateComplete)
    }
    
    func deleteLink(link: LinkModel) {
        linkRepository.deleteLink(link: link)
    }
    
    func showError(viewController: UIViewController, titleError: ErrorTitle, messageError: String) {
        AlertView.showAlertErrorMessage(viewController: viewController, titleError: titleError, messageError: messageError)
    }
}
