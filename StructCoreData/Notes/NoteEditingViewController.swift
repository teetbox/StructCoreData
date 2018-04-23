//
//  AddNoteViewController.swift
//  StructCoreData
//
//  Created by Tong Tian on 23/04/2018.
//  Copyright © 2018 TeetBox. All rights reserved.
//

import UIKit

class NoteEditingViewController: UIViewController {
    
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
    
    let contentTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = UITextBorderStyle.roundedRect
        return textField
    }()
    
    func setupViews() {
        view.addSubview(contentLabel)
        view.addConstraints(format: "H:|-18-[v0]", views: contentLabel)
        view.addConstraints(format: "V:[v0]", views: contentLabel)
        contentLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        
        view.addSubview(contentTextField)
        view.addConstraints(format: "H:|-18-[v0]-18-|", views: contentTextField)
        view.addConstraints(format: "V:[v0(80)]", views: contentTextField)
        contentTextField.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 10).isActive = true
    }
    
    @objc func handleCancel() {
        dismiss(animated: true)
    }
    
    @objc func handleDone() {
        dismiss(animated: true)
    }
    
}
