//
//  TaggedPresenter.swift
//  Tumblr
//
//  Created by Valerii Petrychenko on 6/22/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation

enum TaggedState {
    case search
    case favourites
}

protocol TaggedView: class {
    func reloadInfo()
}

class TaggedPresenter {
    private weak var view: TaggedView?
    private var coordinator: MainCoordinator?
    private let taggedState: TaggedState
    private let limit = 20
    private var posts = [Post]()
    var postsToShow: [Post] {
        return posts
    }
    
    init(view: TaggedView, coordinator: MainCoordinator, taggedState: TaggedState) {
        self.view = view
        self.coordinator = coordinator
        self.taggedState = taggedState
    }
    
    func loadPosts(tag: String) {
        switch taggedState {
        case .search:
            loadRemotePosts(tag: tag, limit: limit)
        case .favourites:
            loadLocalPosts(tag: tag)
        }
    }
    
    func isAdded(id: Int) -> Bool {
        return RealmManager.isAddedPost(id: id)
    }
    
    func presentDetailedViewController(post: Post) {
        let isPostAdded = isAdded(id: post.id)
        switch taggedState {
        case .search:
            coordinator?.presentDetailedViewControllerSearch(delegate: self, isPostAdded: isPostAdded, post: post)
        case .favourites:
            coordinator?.presentDetailedViewControllerFavourites(delegate: self, isPostAdded: isPostAdded, post: post)
        }
    }
    
    private func loadRemotePosts(tag: String, limit: Int) {
        TaggedRequestService.getTagged(tag: tag, limit: limit) { (taggedResponse, error) in
            if let taggedResponse = taggedResponse {
                self.posts = taggedResponse.response
                self.view?.reloadInfo()
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    private func loadLocalPosts(tag: String) {
        posts = RealmManager.loadPostsFromRealm().filter({ $0.tags.contains(tag) })
        view?.reloadInfo()
    }
}

extension TaggedPresenter: AddDeleteDelegate {
    func savePost(id: Int) {
        print("save \(id)")
        if let post = posts.filter({ $0.id == id }).first {
            RealmManager.addPostToRealm(post: post)
            view?.reloadInfo()
        }
    }
    
    func deletePost(id: Int) {
        print("delete \(id)")
        if let postId = posts.filter({ $0.id == id }).first?.id {
            RealmManager.disablePostRealm(postId: postId)
            view?.reloadInfo()
        }
    }
}
