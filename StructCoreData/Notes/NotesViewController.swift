//
//  NotesViewController.swift
//  StructCoreData
//
//  Created by Tong Tian on 23/04/2018.
//  Copyright © 2018 TeetBox. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController {
    
    let dataModel: NotesDataModelProtocol = NotesDataModel()
    var book: Book?
    var notes: [Note]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAdd))
        view.backgroundColor = .white
        
        setupViews()
        
        bookTitle.text = book?.title
        bookAuthor.text = book?.author?.name
        bookPublisher.text = book?.publisher
        bookPrice.text = "$\(book?.price ?? 0.0)"
    }
    
    let bookView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let bookTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.text = "Hello Swift"
        return label
    }()
    
    let bookAuthor: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "Apple"
        return label
    }()
    
    let bookPublisher: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "WordPress"
        label.textColor = .darkGray
        return label
    }()
    
    let bookPrice: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "$9.99"
        label.textColor = .darkGray
        return label
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        table.register(NotesTableViewCell.self, forCellReuseIdentifier: "Cell")
        return table
    }()
    
    func setupViews() {
        view.addSubview(bookView)
        view.addConstraints(format: "H:|[v0]|", views: bookView)
        view.addConstraints(format: "V:[v0(140)]", views: bookView)
        bookView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        bookView.addSubview(bookTitle)
        bookView.addSubview(bookAuthor)
        bookView.addSubview(bookPublisher)
        bookView.addSubview(bookPrice)
        bookView.addConstraints(format: "H:|-15-[v0]-15-|", views: bookTitle)
        bookView.addConstraints(format: "H:|-15-[v0]-15-|", views: bookAuthor)
        bookView.addConstraints(format: "H:|-15-[v0]", views: bookPublisher)
        bookView.addConstraints(format: "H:[v0]-15-|", views: bookPrice)
        bookView.addConstraints(format: "V:|[v0(60)][v1(40)]-10-[v2(20)]-10-|", views: bookTitle, bookAuthor, bookPublisher)
        bookPrice.centerYAnchor.constraint(equalTo: bookPublisher.centerYAnchor).isActive = true
        
        view.addSubview(tableView)
        view.addConstraints(format: "H:|[v0]|", views: tableView)
        view.addConstraints(format: "V:[v0]|", views: tableView)
        tableView.topAnchor.constraint(equalTo: bookView.bottomAnchor).isActive = true
    }
    
    func fetchNotes() {
        dataModel.fetchNotes { _ in
            self.tableView.reloadData()
        }
    }
    
    @objc func handleAdd() {
        let noteEditingViewController = NoteEditingViewController()
        noteEditingViewController.book = book
        
        let noteEditingNavigation = UINavigationController(rootViewController: noteEditingViewController)
        navigationController?.present(noteEditingNavigation, animated: true)
    }
    
}

extension NotesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NotesTableViewCell
        
        guard let note = notes?[indexPath.row] else {
            return cell
        }
        
        cell.content.text = note.content
        cell.username.text = note.user?.username
        cell.email.text = note.user?.email
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor(white: 0.9, alpha: 1)
        } else {
            cell.backgroundColor = UIColor(white: 0.9, alpha: 0.3)
        }
        return cell
    }
    
}
