//
//  Extension.swift
//  Simpy Note
//
//  Created by Khin Phone Ei on 12/03/2023.
//

import UIKit

extension UIViewController {
    func navigateBackToHome() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "homeViewController")
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(vc!)
    }
    
    func hideKeyboardWhenTappedAround() {
            let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
            tap.cancelsTouchesInView = false
            view.addGestureRecognizer(tap)
        }
        
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
