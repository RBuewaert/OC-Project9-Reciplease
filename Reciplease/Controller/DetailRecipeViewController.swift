//
//  DetailRecipeViewController.swift
//  Reciplease
//
//  Created by Romain Buewaert on 17/09/2021.
//

import UIKit
import SafariServices

//
// PAGE INUTILE !!!!!! (IDEM AVEC LES STORYBOARD ASSOCIES !!!)
//

final class DetailRecipeViewController: UIViewController {
    var selectedUrl = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    private func openRecipeWithUrl(_ url: String) {
        
        guard let url = URL(string: url) else { return }
        
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true

        let vc = SFSafariViewController(url: url, configuration: config)
        present(vc, animated: true)
        
        
//        if let url = URL(string: url) {
//            let config = SFSafariViewController.Configuration()
//            config.entersReaderIfAvailable = true
//
//            let vc = SFSafariViewController(url: url, configuration: config)
//            present(vc, animated: true)
//        }
        
    }
    
    
    private func openLink(_ stringURL: String) {
        guard let url = URL(string: stringURL) else {
            // We should handle an invalid stringURL
            return
        }

        // Present SFSafariViewController
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
    }
    
}
