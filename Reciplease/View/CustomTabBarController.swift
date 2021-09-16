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

        // Do any additional setup after loading the view.

        let tabBarItemAppearance = UITabBarItem.appearance()
        let attributes = [NSAttributedString.Key.font:UIFont(name: "Chalkduster", size: 20)]
        tabBarItemAppearance.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
        navigationItem.backButtonTitle = "Back"
       
//        tabBar.layer.borderWidth = 2.0
//        tabBar.layer.borderColor = #colorLiteral(red: 0.5197287798, green: 0.5297763944, blue: 0.5338007212, alpha: 1)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
