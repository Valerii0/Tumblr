//
//  ImageCache.swift
//  Tumblr
//
//  Created by Valerii Petrychenko on 6/23/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import UIKit

final class ImageCache {
    private let imageCach = NSCache<NSString, UIImage>()
    static let shared = ImageCache()
    private init() {}
    
    private func saveImageInCache(image: UIImage, imageName: String) {
        imageCach.setObject(image, forKey: NSString(string: imageName))
    }
    
    private func getImageFromCache(imageName: String) -> UIImage? {
        return imageCach.object(forKey: NSString(string: imageName))
    }
    
    func loadImage(imageUrl: String, callBack: @escaping (_ image: UIImage, _ imageUrl: String) -> Void)  {
        if let cachedImage = getImageFromCache(imageName: imageUrl) {
            callBack(cachedImage, imageUrl)
        } else {
            DispatchQueue.global(qos: .userInitiated).async {
                guard let url = URL(string: imageUrl) else { callBack(self.defaultImage(imageUrl: imageUrl), imageUrl); return }
                do {
                    let data = try Data.init(contentsOf: url)
                    if let image = UIImage.init(data: data) {
                        self.saveImageInCache(image: image, imageName: imageUrl)
                        callBack(image, imageUrl)
                    } else {
                        print("can't take an image from data")
                        callBack(self.defaultImage(imageUrl: imageUrl), imageUrl)
                    }
                } catch {
                    print("wrong url - " + "\(url)")
                    callBack(self.defaultImage(imageUrl: imageUrl), imageUrl)
                }
            }
        }
    }
    
    private func defaultImage(imageUrl: String) -> UIImage {
        let image = UIImage()
        saveImageInCache(image: image, imageName: imageUrl)
        return image
    }
}
