//
//  DetailedPresenter.swift
//  Tumblr
//
//  Created by Valerii Petrychenko on 6/23/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation

protocol DetailedView: class {
}

class DetailedPresenter {
    private weak var view: DetailedView?
    private var coordinator: MainCoordinator?
    weak var delegate: AddDeleteDelegate?
    var isPostAdded: Bool
    var post: Post
    
    init(view: DetailedView, coordinator: MainCoordinator, delegate: AddDeleteDelegate?, isPostAdded: Bool, post: Post) {
        self.view = view
        self.coordinator = coordinator
        self.delegate = delegate
        self.isPostAdded = isPostAdded
        self.post = post
    }
}
