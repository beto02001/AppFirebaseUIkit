//
//  UserLogedViewController.swift
//  firebaseUIkit
//
//  Created by Luis Humberto on 22/02/24.
//

import UIKit

protocol InformationDataTable: AnyObject {
    func successfulInfo(links: [LinkModel])
    func errorCreateLink(error: String)
}

class UserLogedViewController: UIViewController{
    
    
    @IBOutlet weak var textLink: UITextView!
    
    var linkViewModel: LinkViewModel = LinkViewModel()
    var autheticationViewModel: AuthenticationViewModel?
    var links: [LinkModel] = []
    
    @IBOutlet weak var tableViewLinks: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        linkViewModel.getAllLinks()
        print(linkViewModel.linksModel)
        // Do any additional setup after loading the view.
    }
    
    func setDelegates() {
        tableViewLinks.delegate = self
        tableViewLinks.dataSource = self
        linkViewModel.delegateInfoTable = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    func logoutSession() {
        do {
            try autheticationViewModel?.logout()
            navigationController?.popViewController(animated: true)
        } catch {
            print("Error")
        }
    }
    
    @IBAction func actionLogout(_ sender: UIButton) {
        logoutSession()
    }
    
    
    @IBAction func saveLinkButton(_ sender: Any) {
        linkViewModel.createNewLink(url: textLink.text)
    }
}

extension UserLogedViewController: InformationDataTable {
    func errorCreateLink(error: String) {
        DispatchQueue.main.async {
            self.linkViewModel.showError(viewController: self, titleError: .errorCreateLink, messageError: error)
        }
    }
    
    func successfulInfo(links: [LinkModel]) {
        self.links = links
        DispatchQueue.main.async {
            self.tableViewLinks.reloadData()
        }
    }
}

extension UserLogedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.links.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "linkCell")
        let data = self.links[indexPath.row]
        cell.textLabel?.text = data.title
        cell.detailTextLabel?.text = data.url
        cell.accessoryType = data.isCompleted ? .checkmark : .none
        cell.imageView?.image = data.isFavorited ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let eliminate = UIContextualAction(style: .destructive, title: "Eliminar") { (action, sourceView, completionHandler) in
            self.linkViewModel.deleteLink(link: self.links[indexPath.row])
            completionHandler(true)
        }

        eliminate.image = UIImage(systemName: "trash.fill")
        let swipeAction = UISwipeActionsConfiguration(actions: [eliminate])
        swipeAction.performsFirstActionWithFullSwipe = false
        return swipeAction
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favorited = UIContextualAction(style: .normal, title: "Favorito") { (action, sourceView, completionHandler) in
            self.linkViewModel.updateIsFavorited(link: self.links[indexPath.row])
            completionHandler(true)
        }
        favorited.image = UIImage(systemName: "star.fill")
        favorited.backgroundColor = .orange
    
        let completed = UIContextualAction(style: .normal, title: "Completado") { (action, sourceView, completionHandler) in
            self.linkViewModel.updateIsComplete(link: self.links[indexPath.row])
            completionHandler(true)
        }
        completed.image = UIImage(systemName: "checkmark.circle.fill")
        completed.backgroundColor = .blue
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [favorited, completed])
        swipeConfiguration.performsFirstActionWithFullSwipe = false
        
        return swipeConfiguration
    }
    
}

