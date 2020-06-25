//
//  Post.swift
//  Tumblr
//
//  Created by Valerii Petrychenko on 6/23/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

@objcMembers class Post: Object, Codable {
    dynamic var id: Int = 0
    dynamic var type: String = ""
    dynamic var blog_name: String = ""
    //@objc dynamic var blog: Blog
    dynamic var tags = RealmSwift.List<String>()
    dynamic var summary: String? = nil
    dynamic var note_count: Int = 0
    dynamic var caption: String? = nil
    dynamic var body: String? = nil
    dynamic var photos = RealmSwift.List<Photo>()
    dynamic var isLiked: Bool = false
    
    private enum CodingKeys: String, CodingKey {
        case id = "id", type = "type", blog_name = "blog_name",
        //blog = "blog",
        tags = "tags", summary = "summary",
        note_count = "note_count", caption = "caption", body = "body", photos = "photos"
    }
    
    required init(from decoder: Decoder) throws {
        super.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        type = try container.decode(String.self, forKey: .type)
        blog_name = try container.decode(String.self, forKey: .blog_name)
        //blog = try container.decode(Blog.self, forKey: .blog)
        if let tags = try? container.decode([String].self, forKey: .tags) {
            self.tags.append(objectsIn: tags)
        }
        summary = try? container.decode(String.self, forKey: .summary)
        note_count = try container.decode(Int.self, forKey: .note_count)
        caption = try? container.decode(String.self, forKey: .caption)
        body = try? container.decode(String.self, forKey: .body)
        if let photos = try? container.decode([Photo].self, forKey: .photos) {
            self.photos.append(objectsIn: photos)
        }
    }
    
    override static func primaryKey() -> String?
    {
        return "id"
    }
    
    required init()
    {
        super.init()
    }
}
