//
//  BookEditingViewController.swift
//  StructCoreData
//
//  Created by Matt Tian on 2018/4/24.
//  Copyright © 2018 TeetBox. All rights reserved.
//

import UIKit

class BookEditingViewController: UIViewController {
    
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
