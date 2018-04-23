//
//  UIView+Constraint.swift
//  StructCoreData
//
//  Created by Tong Tian on 23/04/2018.
//  Copyright © 2018 TeetBox. All rights reserved.
//

import UIKit

extension UIView {
    
    func addConstraints(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
}
