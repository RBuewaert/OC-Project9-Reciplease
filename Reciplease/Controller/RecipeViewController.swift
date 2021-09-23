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

    var selectedRecipe: RecipeProtocol?
    var selectedRecipeImage = UIImage()

    override func viewDidLoad() {
        super.viewDidLoad()

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

    @IBAction func tappedGetDirectionsButton(_ sender: Any) {
        guard let currentRecipe = selectedRecipe else { return }
        let currentUrl = currentRecipe.recipeUrl()
        print(currentUrl)
    }

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
        titleLabel.text = recipeToLoad.recipeTitle()
        ingredientsTextView.text = recipeToLoad.recipeIngredientsDetailed()

        noteLabel.text = "\(recipeToLoad.recipeNote())"

        if recipeToLoad.recipeTime() > 0 {
            timeLabel.text = "\(recipeToLoad.recipeTime()) min"
        } else {
            timeLabel.text = ""
        }

        recipeImageView.image = selectedRecipeImage
    }

    @objc private func addToFavorite() {
        guard let currentRecipe = selectedRecipe else { return }

        let recipeToSave = RecipeSaved(context: AppDelegate.viewContext)
        recipeToSave.title = currentRecipe.recipeTitle()
        recipeToSave.imageUrl = currentRecipe.recipeImageUrl()
        recipeToSave.url = currentRecipe.recipeUrl()
        recipeToSave.ingredientListDetailed = currentRecipe.recipeIngredientsDetailed()
        recipeToSave.totalTime = currentRecipe.recipeTime()

        print("dishType reçu: \(currentRecipe.recipeDishType())")

        for dishType in currentRecipe.recipeDishType() {
            if !DishType().dishTypeIsExisting(dishType) {
                let dishTypeToSave = DishType(context: AppDelegate.viewContext)
                dishTypeToSave.type = dishType
                recipeToSave.addToDishTypes(dishTypeToSave)
            } else {
                guard let currentDishType = DishType().returnExistingDishType(dishType) else { return }
                recipeToSave.addToDishTypes(currentDishType)
            }
        }

        print("dishType sauvegardé: \(recipeToSave.dishTypes?.allObjects)")
        
        do {
            try AppDelegate.viewContext.save()
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star.fill"), style: .plain, target: self, action: #selector(removeFavorite))
            alertMessageForUser(title: "Succes!", message: "Recipe added to favorite")
        } catch {
            alertMessageForUser(title: "Error!", message: "Favorite not saved")
        }
    }

    @objc private func removeFavorite() {
        
    }

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
