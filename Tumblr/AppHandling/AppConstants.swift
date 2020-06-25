//
//  AppConstants.swift
//  Tumblr
//
//  Created by Valerii Petrychenko on 6/22/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

enum Api: String {
    case url = "https://api.tumblr.com/v2"
    case myKey = "mLZYu3X4iypVGX4rKqXi0xJy5VKdJRDqUaMjONpYGnk4kKenyj"
    case tagged = "/tagged"
    case blog = "/blog"
}

enum AssetsPathConstants: String {
    case delete = "delete"
    case heart = "heart"
}

enum TaggedConstants: String {
    case mainTableViewCell = "MainTableViewCell"
}

enum DetailedConstants: String {
    case headerString = "<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>"
}
