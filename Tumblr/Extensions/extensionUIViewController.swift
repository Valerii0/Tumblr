//
//  extensionUIViewController.swift
//  Tumblr
//
//  Created by Valerii Petrychenko on 6/24/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import UIKit

extension UIViewController {
    ///hide keyboard on tap
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(UIViewController.dismissKeyboard))
        ///???????????
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
