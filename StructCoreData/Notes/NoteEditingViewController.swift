//
//  AddNoteViewController.swift
//  StructCoreData
//
//  Created by Tong Tian on 23/04/2018.
//  Copyright © 2018 TeetBox. All rights reserved.
//

import UIKit

class NoteEditingViewController: UIViewController {
    
    let dataModel: NotesDataModelProtocol = NotesDataModel()
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDone))
        view.backgroundColor = .white
        
        setupViews()
    }
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Note:"
        return label
    }()
    
    let contentTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 18.0)
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 3
        return textView
    }()
    
    let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        textField.borderStyle = UITextBorderStyle.roundedRect
        return textField
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = UITextBorderStyle.roundedRect
        return textField
    }()
    
    func setupViews() {
        view.addSubview(contentLabel)
        view.addConstraints(format: "H:|-18-[v0]", views: contentLabel)
        view.addConstraints(format: "V:[v0]", views: contentLabel)
        contentLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        
        view.addSubview(contentTextView)
        view.addConstraints(format: "H:|-18-[v0]-18-|", views: contentTextView)
        view.addConstraints(format: "V:[v0(80)]", views: contentTextView)
        contentTextView.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 10).isActive = true
        
        view.addSubview(usernameTextField)
        view.addConstraints(format: "H:|-18-[v0]-18-|", views: usernameTextField)
        view.addConstraints(format: "V:[v0(44)]", views: usernameTextField)
        usernameTextField.topAnchor.constraint(equalTo: contentTextView.bottomAnchor, constant: 40).isActive = true
        
        view.addSubview(emailTextField)
        view.addConstraints(format: "H:|-18-[v0]-18-|", views: emailTextField)
        view.addConstraints(format: "V:[v0(44)]", views: emailTextField)
        emailTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20).isActive = true
    }
    
    @objc func handleCancel() {
        dismiss(animated: true)
    }
    
    @objc func handleDone() {
        guard let content = contentTextView.text else { return }
        guard let username = usernameTextField.text else { return }
        guard let email = emailTextField.text else { return }
        
        if content == "" || username == "" || email == "" {
            return
        }
        
        let user = User(uuid: UUID().uuidString, username: username, email: email)
        let note = Note(uuid: UUID().uuidString, content: content, createDate: Date(), updateDate: Date(), user: user)
        book?.notes?.append(note)
        
        dataModel.insertNote(note)
        
        dismiss(animated: true)
    }
    
}
