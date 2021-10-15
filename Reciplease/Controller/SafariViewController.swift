//
//  SafariViewController.swift
//  Reciplease
//
//  Created by Romain Buewaert on 15/10/2021.
//

import UIKit
import SafariServices

final class SafariViewController: SFSafariViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
}
