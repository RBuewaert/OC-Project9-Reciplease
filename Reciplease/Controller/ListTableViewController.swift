//
//  ListTableViewController.swift
//  Reciplease
//
//  Created by Romain Buewaert on 13/09/2021.
//

import UIKit

final class ListTableViewController: UITableViewController {
    // MARK: - Properties
    private let recipeManage = RecipeManage()
    var ingredients = ""
    var recipeList = RecipeList(list: [])
    var findMoreRecipe = false

    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Reciplease"
        navigationItem.backButtonTitle = "Back"
        tableView.rowHeight = 200

        recipeManage.getFirstRecipes(ingredients: ingredients) { [weak self] result in
            switch result {
            case .success(let recipeList):
                self?.recipeList = recipeList
                self?.tableView.reloadData()
            case .failure(let error):
                self?.alertErrorMessageWithReturnToLastVC(message: error.rawValue)
            }
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeList.list.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)
                as? RecipeTableViewCell else {
            return UITableViewCell()
        }

        let recipe = recipeList.list[indexPath.row]

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

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Recipe") as? RecipeViewController {
            vc.selectedRecipe = recipeList.list[indexPath.row]

            guard let currentCell = tableView.cellForRow(at: indexPath) as? RecipeTableViewCell else { return }
            guard let currentImage = currentCell.recipeImageView.image else { return }
            vc.selectedRecipeImage = currentImage

            navigationController?.pushViewController(vc, animated: true)
        }
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let positionY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if positionY > contentHeight - scrollView.frame.height * 3, RecipeManage.urlNextPage != "" {
            if !findMoreRecipe {
                loadMoreRecipe()
            }
        }
    }

    // MARK: - Private methods
    private func createFooterActivityIndicator() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .white
        activityIndicator.center = footerView.center
        footerView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        footerView.translatesAutoresizingMaskIntoConstraints = false

        return footerView
    }

    private func loadMoreRecipe() {
        findMoreRecipe = true
        self.tableView.tableFooterView = createFooterActivityIndicator()

        self.recipeManage.getOtherRecipes { [weak self] result in
            self?.tableView.tableFooterView = nil
            switch result {
            case .success(let nextRecipeList):
                for recipe in nextRecipeList.list {
                    self?.recipeList.list.append(recipe)
                }
                self?.findMoreRecipe = false
                self?.tableView.reloadData()
                print(self?.recipeList.list.count ?? "")
            case .failure(let error):
                self?.alertErrorMessage(message: error.rawValue)
            }
        }
    }
}

extension ListTableViewController {
    // MARK: - UIAlertController
    private func alertErrorMessageWithReturnToLastVC(message: String) {
        let alertVC = UIAlertController(title: "Error!", message: message,
                                        preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { [weak self] _ in
            self?.returnToPreviousVC()
        }))
        self.present(alertVC, animated: true, completion: nil)
    }

    private func alertErrorMessage(message: String) {
        let alertVC = UIAlertController(title: "Error!", message: message,
                                        preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }

    private func returnToPreviousVC() {
        if (storyboard?.instantiateViewController(identifier: "Research") as? SearchViewController) != nil {
            navigationController?.popViewController(animated: true)
        }
    }
}
