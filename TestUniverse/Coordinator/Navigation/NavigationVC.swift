//
//  NavigationVC.swift
//  TestUniverse
//
//  Created by Mykyta Kurochka on 02.11.2025.
//

import Foundation
import UIKit

class NavigationVC: UINavigationController {

    override func viewDidLoad() {
           super.viewDidLoad()
           let appearance = UINavigationBarAppearance()
           appearance.configureWithTransparentBackground()
           appearance.backgroundColor = .clear
           appearance.titleTextAttributes = [
               .font: UIFont.systemFont(ofSize: 26, weight: .regular),
               .foregroundColor: UIColor.color1A1A1A
           ]
           navigationBar.tintColor = .color1A1A1A
           navigationBar.standardAppearance = appearance
           navigationBar.scrollEdgeAppearance = appearance
           navigationBar.isHidden = false
           
       }
       
       override var preferredStatusBarStyle: UIStatusBarStyle {
           .lightContent
       }

}
