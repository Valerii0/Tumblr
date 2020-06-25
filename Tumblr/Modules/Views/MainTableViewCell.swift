//
//  MainTableViewCell.swift
//  Tumblr
//
//  Created by Valerii Petrychenko on 6/23/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var mainTextLabel: UILabel!
    @IBOutlet weak var hashtagsLabel: UILabel!
    @IBOutlet weak var mainImageHeight: NSLayoutConstraint!
    
    private var imageUrl: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    
    private func setUpUI() {
        setUpLabels()
    }
    
    private func setUpLabels() {
        setUpMainTextLabel()
        setUpHashtagsLabel()
    }
    
    private func setUpMainTextLabel() {
        mainTextLabel.textAlignment = .left
        mainTextLabel.textColor = .black
        mainTextLabel.numberOfLines = 5
    }
    
    private func setUpHashtagsLabel() {
        hashtagsLabel.textAlignment = .left
        hashtagsLabel.textColor = .gray
        hashtagsLabel.numberOfLines = 2
    }
    
    func configure(post: Post) {
        mainTextLabel.text = post.summary
        configureHashtagsLabel(post: post)
        configureMainImage(post: post)
    }
    
    private func configureHashtagsLabel(post: Post) {
        var tags = ""
        post.tags.forEach { (tag) in
            tags.append("#\(tag) ")
        }
        hashtagsLabel.text = tags
    }
    
    private func configureMainImage(post: Post) {
        imageUrl = ""
        mainImage.image = nil
        mainImageHeight.constant = 1
        if let originalSize = post.photos.first?.alt_sizes.first {
            self.imageUrl = originalSize.url
            loadImage(imageUrl: originalSize.url)
            let k = CGFloat(originalSize.width) / CGFloat(originalSize.height)
            mainImageHeight.constant = self.frame.width / k
        }
    }
    
    private func loadImage(imageUrl: String) {
        ImageCache.shared.loadImage(imageUrl: imageUrl) { (image, string) in
            if self.imageUrl == imageUrl {
                DispatchQueue.main.async {
                    self.mainImage.image = image
                }
            }
        }
    }
}
