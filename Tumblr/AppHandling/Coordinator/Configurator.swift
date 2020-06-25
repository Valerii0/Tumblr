//
//  Configurator.swift
//  Tumblr
//
//  Created by Valerii Petrychenko on 6/22/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

protocol TaggedConfigurable {
    func configure(viewController: TaggedViewController, coordinator: MainCoordinator, taggedState: TaggedState)
}

class TaggedConfigurator: TaggedConfigurable {
    func configure(viewController: TaggedViewController, coordinator: MainCoordinator, taggedState: TaggedState) {
        let taggedPresenter = TaggedPresenter(view: viewController, coordinator: coordinator, taggedState: taggedState)
        viewController.presenter = taggedPresenter
    }
}

protocol DetailedConfigurable {
    func configure(viewController: DetailedViewController, coordinator: MainCoordinator, delegate: AddDeleteDelegate?, isPostAdded: Bool, post: Post)
}

class DetailedConfigurator: DetailedConfigurable {
    func configure(viewController: DetailedViewController, coordinator: MainCoordinator, delegate: AddDeleteDelegate?, isPostAdded: Bool, post: Post) {
        let detailedPresenter = DetailedPresenter(view: viewController, coordinator: coordinator, delegate: delegate, isPostAdded: isPostAdded, post: post)
        viewController.presenter = detailedPresenter
    }
}
