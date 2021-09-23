//
//  FavoriteListTableViewController.swift
//  Reciplease
//
//  Created by Romain Buewaert on 20/09/2021.
//

import UIKit

class FavoriteListTableViewController: UITableViewController {
    var recipeList = RecipeList(list: [])
    var dishTypeList = DishType.all

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 200

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dishTypeList = DishType.all
        print(dishTypeList)
        tableView.reloadData()
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }

        let recipe = dishTypeList[indexPath.section].recipeArray[indexPath.row]

        guard let imageUrl = recipe.imageUrl else {
            cell.configureWithDefaultImage(title: recipe.wrappedTitle, ingredients: recipe.wrappedIngredientListDetailed, note: recipe.note, time: recipe.totalTime)
            return cell
        }

        guard imageUrl.hasSuffix(".jpg") || imageUrl.hasSuffix(".png") else {
            cell.configureWithDefaultImage(title: recipe.wrappedTitle, ingredients: recipe.wrappedIngredientListDetailed, note: recipe.note, time: recipe.totalTime)
            return cell
        }
                
        RecipeService.shared.getImage(url: recipe.imageUrl!) { result in
            switch result {
            case .success(let image):
                cell.configure(imageData: image, title: recipe.wrappedTitle, ingredients: recipe.wrappedIngredientListDetailed, note: recipe.note, time: recipe.totalTime)
            case .failure(_):
                cell.configureWithDefaultImage(title: recipe.wrappedTitle, ingredients: recipe.wrappedIngredientListDetailed, note: recipe.note, time: recipe.totalTime)
            }
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let myLabel = UILabel()
        myLabel.frame = CGRect(x: 20, y: 8, width: 320, height: 20)
        myLabel.font = UIFont.boldSystemFont(ofSize: 30)
        myLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        myLabel.textAlignment = .center
        myLabel.numberOfLines = 0
        myLabel.text = self.tableView(tableView, titleForHeaderInSection: section)

        let headerView = UIView()
        headerView.addSubview(myLabel)

        return headerView
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let titleSection = dishTypeList[section].type else { return nil}
        return titleSection
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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
