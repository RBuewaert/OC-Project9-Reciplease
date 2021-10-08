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
        tabBar.backgroundColor = #colorLiteral(red: 0.2142897546, green: 0.1995050907, blue: 0.1910885274, alpha: 1)
    }
}
