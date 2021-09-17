//
//  RecipeViewController.swift
//  Reciplease
//
//  Created by Romain Buewaert on 15/09/2021.
//

import UIKit

class RecipeViewController: UIViewController {
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ingredientsTextView: UITextView!
    @IBOutlet weak var littleView: UIView!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    var selectedRecipe: Recipe?
    var selectedRecipeImage = UIImage()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star.fill"), style: .plain, target: self, action: #selector(removeFavorite))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(addToFavorite))

        
        littleView.layer.cornerRadius = 5
        littleView.layer.borderWidth = 1
        littleView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        updateView()

    }
    
    @IBAction func tappedGetDirectionsButton(_ sender: Any) {
        guard let currentUrl = selectedRecipe?.url else { return }
        print(currentUrl)
    }

    private func updateView() {
        guard let recipeToLoad = selectedRecipe else { return }
        titleLabel.text = recipeToLoad.title
        
        for ingredient in recipeToLoad.ingredientList {
            ingredientsTextView.text.append("- \(ingredient) \n")
        }
        
        noteLabel.text = "\(recipeToLoad.yield)"
        
        if recipeToLoad.totalTime > 0 {
            timeLabel.text = "\(recipeToLoad.totalTime) min"
        } else {
            timeLabel.text = ""
        }
        
        recipeImageView.image = selectedRecipeImage
    }
    
    @objc private func addToFavorite() {
        
    }
    
    @objc private func removeFavorite() {
        
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
