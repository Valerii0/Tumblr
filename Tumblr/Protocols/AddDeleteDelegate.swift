//
//  AddDeleteDelegate.swift
//  Tumblr
//
//  Created by Valerii Petrychenko on 6/24/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation

protocol AddDeleteDelegate: class {
    func savePost(id: Int)
    func deletePost(id: Int)
}
