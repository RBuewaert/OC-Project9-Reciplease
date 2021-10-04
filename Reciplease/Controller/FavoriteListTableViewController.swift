//
//  FavoriteListTableViewController.swift
//  Reciplease
//
//  Created by Romain Buewaert on 20/09/2021.
//

import UIKit

final class FavoriteListTableViewController: UITableViewController {
    // MARK: - Property
    private let recipeManage = RecipeManage()
    var dishTypeList = DishType.all

    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Reciplease"
        navigationItem.backButtonTitle = "Back"
        tableView.rowHeight = 200
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dishTypeList = DishType.all
        tableView.reloadData()
        if dishTypeList.isEmpty {
            alertMessageForUser()
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return dishTypeList.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let numberOfRows = dishTypeList[section].recipes?.count else { return 1 }
        return numberOfRows
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)
                as? RecipeTableViewCell else {
            return UITableViewCell()
        }

        let recipe = dishTypeList[indexPath.section].recipeArray[indexPath.row]

        guard let imageUrl = recipe.imageUrl else {
            cell.configureWithDefaultImage(title: recipe.recipeTitle, ingredients: recipe.recipeIngredientsName,
                cuisineType: recipe.recipeCuisineType, time: recipe.recipeTime)
            return cell
        }

        guard imageUrl.hasSuffix(".jpg") || imageUrl.hasSuffix(".png") else {
            cell.configureWithDefaultImage(title: recipe.recipeTitle, ingredients: recipe.recipeIngredientsName,
                cuisineType: recipe.recipeCuisineType, time: recipe.recipeTime)
            return cell
        }

        recipeManage.getImage(url: recipe.imageUrl!) { result in
            switch result {
            case .success(let image):
                cell.configure(imageData: image, title: recipe.recipeTitle, ingredients: recipe.recipeIngredientsName,
                    cuisineType: recipe.recipeCuisineType, time: recipe.recipeTime)
            case .failure(_):
                cell.configureWithDefaultImage(title: recipe.recipeTitle, ingredients: recipe.recipeIngredientsName,
                    cuisineType: recipe.recipeCuisineType, time: recipe.recipeTime)
            }
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let titleSection = dishTypeList[section].type else { return nil}
        let myLabel = UILabel()
        myLabel.frame = CGRect(x: 20, y: 8, width: 320, height: 32)
        myLabel.font = UIFont.boldSystemFont(ofSize: 30)
        myLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        myLabel.textAlignment = .center
        myLabel.numberOfLines = 0
        myLabel.text = titleSection

        let headerView = UIView()
        headerView.addSubview(myLabel)

        return headerView
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Recipe") as? RecipeViewController {

            vc.selectedRecipe = dishTypeList[indexPath.section].recipeArray[indexPath.row]

            guard let currentCell = tableView.cellForRow(at: indexPath) as? RecipeTableViewCell else { return }
            guard let currentImage = currentCell.recipeImageView.image else { return }
            vc.selectedRecipeImage = currentImage

            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension FavoriteListTableViewController {
    // MARK: - UIAlertController
    private func alertMessageForUser() {
        let alertVC = UIAlertController(title: "Information!",
                    message: "click on the star to add a recipe on your favorite list", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}
