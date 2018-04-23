//
//  BookStoreViewController.swift
//  StructCoreData
//
//  Created by Tong Tian on 22/04/2018.
//  Copyright © 2018 TeetBox. All rights reserved.
//

import UIKit

class StoresViewController: UIViewController {

    @IBOutlet weak var amazonButton: UIButton!
    @IBOutlet weak var safariButton: UIButton!
    
    let dataModel: StoresDataModelProtocol = StoresDataModel()
    var stores: [Store]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        amazonButton.setTitle("Hello", for: .normal)
        safariButton.setTitle("Swift", for: .normal)

        fetchStores()
    }
    
    func fetchStores() {
        dataModel.fetchStores { stores in
            self.stores = stores
            
            guard let amazon = stores?[0].brand else { return }
            guard let safari = stores?[1].brand else { return }
            
            self.amazonButton.setTitle(amazon, for: .normal)
            self.safariButton.setTitle(safari, for: .normal)
        }
    }
    
    @IBAction func showAmazon(_ sender: UIButton) {
        let booksViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BooksViewController") as! BooksViewController
        booksViewController.navigationItem.title = "Amazon"
        booksViewController.books = stores?[0].books
        navigationController?.pushViewController(booksViewController, animated: true)
    }
    
    @IBAction func showSafari(_ sender: UIButton) {
        let booksViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BooksViewController") as! BooksViewController
        booksViewController.navigationItem.title = "Safari"
        booksViewController.books = stores?[1].books
        navigationController?.pushViewController(booksViewController, animated: true)
    }
    
}

