//
//  FooterView.swift
//  Tumblr
//
//  Created by Valerii Petrychenko on 6/23/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import UIKit

class FooterView: UIView {
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var addDeleteButton: UIButton!
    
    private var id: Int = 0
    private var isPostAdded: Bool = false
    weak var delegate: AddDeleteDelegate?
    
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
        setUpNotesLabel()
        addDeleteButton.setTitle(nil, for: .normal)
    }
    
    private func setUpBg() {
        self.backgroundColor = .white
    }
    
    private func setUpNotesLabel() {
        notesLabel.textAlignment = .left
        notesLabel.textColor = .gray
        notesLabel.numberOfLines = 1
    }
    
    func configure(post: Post, isPostAdded: Bool) {
        self.id = post.id
        notesLabel.text = "\(post.note_count) notes"
        self.isPostAdded = isPostAdded
        configureAddDeleteButton()
    }
    
    private func configureAddDeleteButton() {
        if isPostAdded {
            addDeleteButton.setImage(UIImage(named: AssetsPathConstants.delete.rawValue)?.withRenderingMode(.alwaysOriginal), for: .normal)
        } else {
            addDeleteButton.setImage(UIImage(named: AssetsPathConstants.heart.rawValue)?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }
    
    @IBAction func addDeleteAction(_ sender: UIButton) {
        if isPostAdded {
            delegate?.deletePost(id: id)
        } else {
            delegate?.savePost(id: id)
        }
        isPostAdded = !isPostAdded
        configureAddDeleteButton()
    }
}
