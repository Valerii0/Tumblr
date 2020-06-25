//
//  DetailedViewController.swift
//  Tumblr
//
//  Created by Valerii Petrychenko on 6/23/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import UIKit
import WebKit

class DetailedViewController: UIViewController, Storyboarded {
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var footerView: FooterView!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var hashtagsLabel: UILabel!
    @IBOutlet weak var captionWebView: WKWebView!
    @IBOutlet weak var bodyWebView: WKWebView!
    @IBOutlet weak var mainImageHeight: NSLayoutConstraint!
    @IBOutlet weak var captionWebViewHeight: NSLayoutConstraint!
    @IBOutlet weak var bodyWebViewHeight: NSLayoutConstraint!
    
    var presenter: DetailedPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        configure()
    }
    
    private func setUpUI() {
        setUpLabels()
        setUpWebViews()
    }
    
    private func setUpLabels() {
        setUpHashtagsLabel()
    }
    
    private func setUpHashtagsLabel() {
        hashtagsLabel.textAlignment = .left
        hashtagsLabel.textColor = .gray
        hashtagsLabel.numberOfLines = 0
    }
    
    private func setUpWebViews() {
        captionWebView.navigationDelegate = self
        bodyWebView.navigationDelegate = self
        
        captionWebView.backgroundColor = .clear
        bodyWebView.backgroundColor = .clear
    }
    
    func configure() {
        let post = presenter.post
        headerView.configure(post: post)
        footerView.configure(post: post, isPostAdded: presenter.isPostAdded)
        footerView.delegate = presenter.delegate
        configureMainImage(post: post)
        configureHashtagsLabel(post: post)
        loadCaptionWebView(post: post)
        loadBodyWebView(post: post)
    }
    
    private func configureMainImage(post: Post) {
        if let originalSize = post.photos.first?.alt_sizes.first {
            loadImage(imageUrl: originalSize.url)
            let k = CGFloat(originalSize.width) / CGFloat(originalSize.height)
            mainImageHeight.constant = self.view.frame.width / k
        } else {
            mainImage.image = nil
            mainImageHeight.constant = 1
        }
    }
    
    private func loadImage(imageUrl: String) {
        ImageCache.shared.loadImage(imageUrl: imageUrl) { (image, string) in
            DispatchQueue.main.async {
                self.mainImage.image = image
            }
        }
    }
    
    private func configureHashtagsLabel(post: Post) {
        var tags = ""
        post.tags.forEach { (tag) in
            tags.append("#\(tag) ")
        }
        hashtagsLabel.text = tags
    }
    
    private func loadCaptionWebView(post: Post) {
        if let caption = post.caption {
            captionWebView.loadHTMLString(DetailedConstants.headerString.rawValue + caption, baseURL: Bundle.main.bundleURL)
        }
    }
    
    private func loadBodyWebView(post: Post) {
        if let body = post.body {
            bodyWebView.loadHTMLString(DetailedConstants.headerString.rawValue + body, baseURL: nil)
        }
    }
    
    private func configureWebViewHeights(webView: WKWebView) {
        if webView === captionWebView {
            captionWebViewHeight.constant = captionWebView.scrollView.contentSize.height
        } else if webView === bodyWebView {
            bodyWebViewHeight.constant = bodyWebView.scrollView.contentSize.height
        }
    }
}

extension DetailedViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.configureWebViewHeights(webView: webView)
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.navigationType == .linkActivated  {
            if let url = navigationAction.request.url,
                let host = url.host, !host.hasPrefix("www.google.com"),
                UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
                print(url)
                print("Redirected to browser. No need to open it locally")
                decisionHandler(.cancel)
            } else {
                print("Open it locally")
                decisionHandler(.allow)
            }
        } else {
            print("not a user click")
            decisionHandler(.allow)
        }
    }
}

extension DetailedViewController: DetailedView {
}
