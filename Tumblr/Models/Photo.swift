//
//  Photo.swift
//  Tumblr
//
//  Created by Valerii Petrychenko on 6/23/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

@objcMembers class Photo: Object, Codable {
    dynamic var caption: String = ""
    //dynamic var original_size = RealmSwift.PhotoSize()
    dynamic var alt_sizes = RealmSwift.List<PhotoSize>()
    
    private enum CodingKeys: String, CodingKey {
        case caption = "caption", //original_size = "original_size",
        alt_sizes = "alt_sizes"
    }
    
    required init(from decoder: Decoder) throws {
        super.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        caption = try container.decode(String.self, forKey: .caption)
//        if let originalSize = try? container.decode(PhotoSize.self, forKey: .original_size) {
//            self.original_size = originalSize
//        }
        if let altSizes = try? container.decode([PhotoSize].self, forKey: .alt_sizes) {
            self.alt_sizes.append(objectsIn: altSizes)
        }
    }
    
//    override static func primaryKey() -> String?
//    {
//        return "caption"
//    }
    
    required init()
    {
        super.init()
    }
}
