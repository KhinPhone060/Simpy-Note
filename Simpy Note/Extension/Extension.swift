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
    
    func navigateToNoteDetail() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "noteDetailViewController")
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(vc!)
    }
}
