//
//  TaggedViewController.swift
//  Tumblr
//
//  Created by Valerii Petrychenko on 6/22/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import UIKit

class TaggedViewController: UIViewController, Storyboarded {
    @IBOutlet weak var findTextField: UITextField!
    @IBOutlet weak var postsTableView: UITableView!
    
    var presenter: TaggedPresenter!
    
    private let headerViewHeight: CGFloat = 50
    private let footerHeight: CGFloat = 60
    private let footerViewHeight: CGFloat = 50
    private var query = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if query.count > 0 {
            presenter.loadPosts(tag: query)
        }
    }
    
    private func setUpUI() {
        setUpView()
        setUpPostsTableView()
        setUpFindTextField()
        hideKeyboardWhenTappedAround()
    }
    
    private func setUpView() {
        self.view.backgroundColor = UIColor(red: 0/255.0, green: 25/255.0, blue: 53/255.0, alpha: 1)
    }
    
    private func setUpPostsTableView() {
        postsTableView.delegate = self
        postsTableView.dataSource = self
        postsTableView.backgroundColor = .clear
        postsTableView.tableFooterView = UIView()
        postsTableView.register(UINib(nibName: TaggedConstants.mainTableViewCell.rawValue, bundle: nil),
                                forCellReuseIdentifier: TaggedConstants.mainTableViewCell.rawValue)
    }
    
    private func setUpFindTextField() {
        findTextField.placeholder = "fill some tag..."
        findTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let searchQuery = textField.text, searchQuery.count > 0 else { return }
        query = searchQuery
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(makeRequest), object: nil)
        perform(#selector(makeRequest), with: nil, afterDelay: 1.0)
    }
    
    @objc private func makeRequest() {
        presenter.loadPosts(tag: query)
    }
}

extension TaggedViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.postsToShow.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaggedConstants.mainTableViewCell.rawValue, for: indexPath) as! MainTableViewCell
        let cellRect = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: UITableView.automaticDimension)
        cell.frame = cellRect
        cell.configure(post: presenter.postsToShow[indexPath.section])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = HeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: headerViewHeight))
        view.configure(post: presenter.postsToShow[section])
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: footerHeight))
        let footerView = FooterView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: footerViewHeight))
        footerView.configure(post: presenter.postsToShow[section], isPostAdded: presenter.isAdded(id: presenter.postsToShow[section].id))
        footerView.delegate = presenter
        view.addSubview(footerView)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerViewHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return footerHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        presenter.presentDetailedViewController(post: presenter.postsToShow[indexPath.section])
    }
}

extension TaggedViewController: TaggedView {
    func reloadInfo() {
        DispatchQueue.main.async {
            self.postsTableView.reloadData()
        }
    }
}
