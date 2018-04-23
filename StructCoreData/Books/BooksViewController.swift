//
//  BooksViewController.swift
//  StructCoreData
//
//  Created by Matt Tian on 2018/4/23.
//  Copyright © 2018 TeetBox. All rights reserved.
//

import UIKit

class BooksViewController: UIViewController {
    
    let dataModel: BooksDataModelProtocol = BooksDataModel()
    var books: [Book]?

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAdd))
    }
    
    @objc func handleAdd() {
        let bookEditingViewController = BookEditingViewController()
        let bookEditingNavigation = UINavigationController(rootViewController: bookEditingViewController)
        navigationController?.present(bookEditingNavigation, animated: true)
    }
    
}

extension BooksViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = books?[indexPath.row].title
        cell.detailTextLabel?.text = books?[indexPath.row].author?.name
        return cell
    }
    
}
