//
//  TaggedRequestService.swift
//  Tumblr
//
//  Created by Valerii Petrychenko on 6/22/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation

final class TaggedRequestService {
    static func getTagged(tag: String, limit: Int, callBack: @escaping (_ taggedResponse: TaggedResponse?, _ error: Error?) -> Void) {
        var urlString = Api.url.rawValue
        urlString.append(Api.tagged.rawValue)
        
        var urlComponents = URLComponents(string: urlString)
        urlComponents?.queryItems = [
            URLQueryItem(name: "tag", value: tag),
            URLQueryItem(name: "limit", value: "\(limit)"),
            URLQueryItem(name: "api_key", value: Api.myKey.rawValue)
        ]
        
        var request = URLRequest(url: (urlComponents?.url)!)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                callBack(nil, error)
            } else if let data = data {
                do {
                    let taggedResponse = try JSONDecoder().decode(TaggedResponse.self, from: data)
                    callBack(taggedResponse, nil)
                } catch {
                    callBack(nil, error)
                }
            }
        }
        task.resume()
    }
}
