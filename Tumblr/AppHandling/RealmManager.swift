//
//  RealmManager.swift
//  Tumblr
//
//  Created by Valerii Petrychenko on 6/24/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

final class RealmManager {
    static func loadPostsFromRealm() -> [Post] {
        do {
            let realm = try Realm()
            let posts = realm.objects(Post.self).filter("isLiked == %@", true)
            posts.forEach({ post in
                print(post.id)
            })
            return Array(posts)
        } catch {
            print(error.localizedDescription)
        }
        return [Post]()
    }
    
    static func addPostToRealm(post: Post) {
        do {
            let realm = try Realm()
            if let realmPost = realm.objects(Post.self).filter("id == %@", post.id).first {
                do {
                    try realm.write {
                        realmPost.isLiked = true
                        realm.add(realmPost, update: .modified)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                do {
                    try realm.write {
                        post.isLiked = true
                        realm.add(post)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func disablePostRealm(postId: Int) {
        do {
            let realm = try Realm()
            if let realmPost = realm.objects(Post.self).filter("id == %@", postId).first {
                do {
                    try realm.write {
                        realmPost.isLiked = false
                        realm.add(realmPost, update: .modified)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func isAddedPost(id: Int) -> Bool {
        do {
            let realm = try Realm()
            if let realmPost = realm.objects(Post.self).filter("id == %@", id).first, realmPost.isLiked {
                return true
            }
        } catch {
            print(error.localizedDescription)
        }
        return false
    }
}
