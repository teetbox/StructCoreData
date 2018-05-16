//
//  BooksViewController.swift
//  StructCoreData
//
//  Created by Matt Tian on 2018/4/23.
//  Copyright © 2018 TeetBox. All rights reserved.
//

import UIKit

class BooksViewController: UIViewController {
    
    var viewModel: BooksViewModel!

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAdd))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let index = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: index, animated: false)
        }

        fetchBooks()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        tableView.flashScrollIndicators()
    }
    
    func fetchBooks() {
        viewModel.loadData() {
            self.tableView.reloadData()
        }
    }
    
    func reloadBooks() {
        let contentOffset = tableView.contentOffset
        tableView.reloadData()
        tableView.layoutIfNeeded()
        tableView.setContentOffset(contentOffset, animated: false)
    }
    
    @objc func handleAdd() {
        let bookEditingViewController = BookEditingViewController()
        let bookEditingNavigation = UINavigationController(rootViewController: bookEditingViewController)
        navigationController?.present(bookEditingNavigation, animated: true)
    }
    
}

extension BooksViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.books?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = viewModel.books?[indexPath.row].title
        cell.detailTextLabel?.text = viewModel.books?[indexPath.row].author?.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let book = viewModel.books?[indexPath.row] else {
            return
        }
        
        let notesViewController = NotesViewController()
        notesViewController.book = book
        notesViewController.notes = book.notes
        
        navigationController?.pushViewController(notesViewController, animated: true)
    }
    
}
