//
//  HeaderView.swift
//  Tumblr
//
//  Created by Valerii Petrychenko on 6/23/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileLabel: UILabel!
    
    private var imageUrl: String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        fromNib()
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fromNib()
        setUpUI()
    }
    
    private func setUpUI() {
        setUpBg()
        setUpProfileImage()
        setUpProfileLabel()
    }
    
    private func setUpBg() {
        self.backgroundColor = .white
    }
    
    private func setUpProfileImage() {
        profileImage.layer.cornerRadius = 5
    }
    
    private func setUpProfileLabel() {
        profileLabel.textAlignment = .left
        profileLabel.textColor = .black
        profileLabel.numberOfLines = 1
        profileLabel.font = profileLabel.font.withSize(15)
    }
    
    private func createURLString(blogName: String) -> String {
        var urlString = Api.url.rawValue
        urlString.append(Api.blog.rawValue)
        urlString.append("/\(blogName)/avatar")
        return urlString
    }
    
    private func loadImage(imageUrl: String) {
        profileImage.image = nil
        ImageCache.shared.loadImage(imageUrl: imageUrl) { (image, string) in
            if self.imageUrl == imageUrl {
                DispatchQueue.main.async {
                    self.profileImage.image = image
                }
            }
        }
    }
    
    func configure(post: Post) {
        profileLabel.text = post.blog_name
        let imageUrl = createURLString(blogName: post.blog_name)
        self.imageUrl = imageUrl
        loadImage(imageUrl: imageUrl)
    }
}
