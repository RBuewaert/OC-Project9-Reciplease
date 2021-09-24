//
//  FavoriteRecipeViewController.swift
//  Reciplease
//
//  Created by Romain Buewaert on 23/09/2021.
//

import UIKit

//
// PAS UTILE !!!!! ON PEUT SUPPRIMER !!!
//

final class FavoriteRecipeViewController: UIViewController {
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ingredientsTextView: UITextView!
    @IBOutlet weak var littleView: UIView!
    @IBOutlet weak var cuisineTypeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    var selectedFavoriteRecipe: RecipeSaved?
    var selectedRecipeImage = UIImage()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star.fill"), style: .plain, target: self, action: #selector(removeFavorite))

        littleView.layer.cornerRadius = 5
        littleView.layer.borderWidth = 1
        littleView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

        updateView()
    }

    @IBAction func tappedGetDirectionsButton(_ sender: Any) {
        guard let currentUrl = selectedFavoriteRecipe?.url else { return }
        print(currentUrl)
    }

    func updateView() {
        guard let recipeToLoad = selectedFavoriteRecipe else { return }
        titleLabel.text = recipeToLoad.title
        ingredientsTextView.text = recipeToLoad.ingredientList
        
        cuisineTypeLabel.text = "\(recipeToLoad.note)"
        
        if recipeToLoad.totalTime > 0 {
            timeLabel.text = "\(recipeToLoad.totalTime) min"
        } else {
            timeLabel.text = ""
        }
        
        recipeImageView.image = selectedRecipeImage
    }

//    @objc func addToFavorite() {
//        guard let currentRecipe = selectedFavoriteRecipe else { return }
//
//        let recipeToSave = RecipeSaved(context: AppDelegate.viewContext)
//        recipeToSave.title = currentRecipe.title
//        recipeToSave.imageUrl = currentRecipe.imageUrl
//        recipeToSave.url = currentRecipe.url
//        recipeToSave.ingredientList = currentRecipe.ingredientList
//        recipeToSave.totalTime = currentRecipe.totalTime
//
//        print("dishType reçu: \(currentRecipe.dishType)")
//
//        for dishType in currentRecipe.dishType {
//            if !DishType().dishTypeIsExisting(dishType) {
//                let dishTypeToSave = DishType(context: AppDelegate.viewContext)
//                dishTypeToSave.type = dishType
//                recipeToSave.addToDishTypes(dishTypeToSave)
//            } else {
//                guard let currentDishType = DishType().returnExistingDishType(dishType) else { return }
//                recipeToSave.addToDishTypes(currentDishType)
//            }
//        }
//
//        print("dishType sauvegardé: \(recipeToSave.dishTypes?.allObjects)")
//
//        do {
//            try AppDelegate.viewContext.save()
//            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star.fill"), style: .plain, target: self, action: #selector(removeFavorite))
//        } catch {
//            alertErrorMessage()
//        }
//    }

    func alertErrorMessage() {
        let alertVC = UIAlertController(title: "Error!", message: "Favorite not saved!",
                                        preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }

    @objc func removeFavorite() {
        
    }
}
