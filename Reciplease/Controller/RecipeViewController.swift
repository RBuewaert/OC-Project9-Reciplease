//
//  RecipeViewController.swift
//  Reciplease
//
//  Created by Romain Buewaert on 15/09/2021.
//

import UIKit
import CoreData
import SafariServices

final class RecipeViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ingredientsTextView: UITextView!
    @IBOutlet weak var littleView: UIView!
    @IBOutlet weak var cuisineTypeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var getDirectionsButton: UIButton!
    
    // MARK: - Properties
    var selectedRecipe: RecipeProtocol?
    var selectedRecipeImage = UIImage()

    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getDirectionsButton.layer.cornerRadius = 5

        if verifyIfRecipeIsOnFavorite() {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star.fill"), style: .plain, target: self, action: #selector(removeFavorite))
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(addToFavorite))
        }

        littleView.layer.cornerRadius = 5
        littleView.layer.borderWidth = 1
        littleView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

        updateView()
    }

    // MARK: - Action
    @IBAction func tappedGetDirectionsButton(_ sender: Any) {
        guard let currentRecipe = selectedRecipe else { return }
        guard let url = URL(string: currentRecipe.recipeUrl) else { return }

        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true

        let vc = SFSafariViewController(url: url, configuration: config)
        present(vc, animated: true)
    }

    // MARK: - Private methods
    private func verifyIfRecipeIsOnFavorite() -> Bool {
        if (selectedRecipe as? RecipeSaved) != nil {
            return true
        }
        if let currentRecipe = selectedRecipe as? Recipe {
            if DishType().recipeIsExisting(currentRecipe) {
                return true
            }
        }
        return false
    }

    private func updateView() {
        guard let recipeToLoad = selectedRecipe else { return }
        titleLabel.text = recipeToLoad.recipeTitle
        ingredientsTextView.text = recipeToLoad.recipeIngredientsList

        cuisineTypeLabel.text = recipeToLoad.recipeCuisineType

        if recipeToLoad.recipeTime > 0 {
            timeLabel.text = "\(recipeToLoad.recipeTime) min"
        } else {
            timeLabel.text = "No Time"
        }

        recipeImageView.image = selectedRecipeImage
    }

    // MARK: - Private methods for NavigationItem Buttons
    @objc private func addToFavorite() {
        guard let currentRecipe = selectedRecipe else { return }

        do {
            try DishType().saveRecipe(currentRecipe)
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star.fill"), style: .plain, target: self, action: #selector(removeFavorite))
            alertMessageForUser(title: "Succes!", message: "Recipe added to favorite")
        } catch {
            alertMessageForUser(title: "Error!", message: ErrorType.saveFailed.rawValue)
        }
    }

    @objc private func removeFavorite() {
        guard let currentRecipe = selectedRecipe as? RecipeSaved else { return }

        do {
            try DishType().removeSavedRecipe(currentRecipe)
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(addToFavorite))
            alertMessageForUser(title: "Succes!", message: "Recipe removed from favorite")
        } catch {
            alertMessageForUser(title: "Error!", message: ErrorType.deletionFailed.rawValue)
        }
    }
}

extension RecipeViewController {
    // MARK: - UIAlertController
    private func alertMessageForUser(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message,
                                        preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
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
