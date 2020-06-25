//
//  PhotoSize.swift
//  Tumblr
//
//  Created by Valerii Petrychenko on 6/23/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

@objcMembers class PhotoSize: Object, Codable {
    dynamic var url: String = ""
    dynamic var width: Int = 0
    dynamic var height: Int = 0
    
    private enum CodingKeys: String, CodingKey {
        case url = "url", width = "width", height = "height"
    }
    
    required init(from decoder: Decoder) throws {
        super.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        url = try container.decode(String.self, forKey: .url)
        width = try container.decode(Int.self, forKey: .width)
        height = try container.decode(Int.self, forKey: .height)
    }
    
    //    override static func primaryKey() -> String?
    //    {
    //        return "url"
    //    }
    
    required init()
    {
        super.init()
    }
}
