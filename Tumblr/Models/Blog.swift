//
//  Blog.swift
//  Tumblr
//
//  Created by Valerii Petrychenko on 6/23/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation

class Blog: Codable {
    var name: String?
    var title: String?
    var description: String?
    var url: String?
    var updated: String?
    
    private enum CodingKeys: String, CodingKey {
        case name = "name", title = "title", description = "description", url = "url", updated = "updated"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        title = try? container.decode(String.self, forKey: .title)
        description = try? container.decode(String.self, forKey: .description)
        url = try? container.decode(String.self, forKey: .url)
        updated = try? container.decode(String.self, forKey: .updated)
    }
}
