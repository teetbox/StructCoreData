//
//  Result.swift
//  StructCoreData
//
//  Created by Matt Tian on 2018/4/23.
//  Copyright © 2018 TeetBox. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}
