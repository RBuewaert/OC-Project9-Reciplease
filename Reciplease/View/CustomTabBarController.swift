//
//  CustomTabBarController.swift
//  Reciplease
//
//  Created by Romain Buewaert on 08/09/2021.
//

import UIKit

class CustomTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let tabBarItemAppearance = UITabBarItem.appearance()
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Chalkduster", size: 18)]
        tabBarItemAppearance.setTitleTextAttributes(attributes as [NSAttributedString.Key: Any],
                                                    for: .normal)
    }
}
