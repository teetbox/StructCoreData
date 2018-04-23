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
    }
    
    @objc func handleCancel() {
        dismiss(animated: true)
    }
    
    @objc func handleDone() {
        dismiss(animated: true)
    }
    
}
