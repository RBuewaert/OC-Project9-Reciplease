//
//  ListTableViewController.swift
//  Reciplease
//
//  Created by Romain Buewaert on 13/09/2021.
//

import UIKit

class ListTableViewController: UITableViewController {
    var ingredients = ""
    var recipeList = RecipeList(list: [])

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 200

        RecipeService.shared.getRecipe(ingredients: ingredients) { result in
            switch result {
            case .success(let recipeList):
                self.recipeList = recipeList
                self.tableView.reloadData()
            case .failure(let error):
                self.alertErrorMessage(message: error.rawValue)
            }
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeList.list.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }

        let recipe = recipeList.list[indexPath.row]
        
        guard let imageUrl = recipe.image else {
            guard let imageData = UIImage(named: "tableSetFlag")?.pngData() else { return UITableViewCell() }
            cell.configure(picture: imageData, title: recipe.title, ingredients: recipe.ingredientList, note: recipe.yield, time: recipe.totalTime)
            return cell
        }
        
        guard imageUrl.hasSuffix(".jpg") || imageUrl.hasSuffix(".png") else {
            guard let imageData = UIImage(named: "tableSetFlag")?.pngData() else { return UITableViewCell() }
            cell.configure(picture: imageData, title: recipe.title, ingredients: recipe.ingredientList, note: recipe.yield, time: recipe.totalTime)
            return cell
        }
        
        RecipeService.shared.getImage(url: recipe.image!) { result in
            switch result {
            case .success(let image):
                cell.configure(picture: image, title: recipe.title, ingredients: recipe.ingredientList, note: recipe.yield, time: recipe.totalTime)
            case .failure(_):
                guard let imageData = UIImage(named: "tableSetFlag")?.pngData() else { return }
                cell.configure(picture: imageData, title: recipe.title, ingredients: recipe.ingredientList, note: recipe.yield, time: recipe.totalTime)
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Recipe") as? RecipeViewController {
            vc.selectedRecipe = recipeList.list[indexPath.row]
            
            let currentCell = tableView.cellForRow(at: indexPath)
//            vc.selectedRecipeImage =
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    // MARK: - UIAlertController
    private func alertErrorMessage(message: String) {
        let alertVC = UIAlertController(title: "Error!", message: message,
                                        preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
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
    
    /*
    https://api.edamam.com/api/recipes/v2?
        type=public&q=chicken, rabbit
     &app_id=06863309&app_key=2b6469119d2a85f1ca18276aae53b131
    
    https://api.edamam.com/api/recipes/v2?
    q=chicken%2C%20rabbit
     &app_key=2b6469119d2a85f1ca18276aae53b131
     &_cont=CHcVQBtNNQphDmgVQ3tAEX4BZ1VtBQMOQGFGBWUaZV10AREbUWBEUDYQMVQlUgAOQW1DCjQRN1F2DABRRjNFBmATMgdyFm4bUTMCXD8BaVdzGBFEEjMVcDNPPBcqUUBlEjsXVnAZKBg-
     &type=public
     &app_id=06863309
     
     https://api.edamam.com/api/recipes/v2?
     q=chicken%2C%20rabbit
     &app_key=2b6469119d2a85f1ca18276aae53b131
     &_cont=CHcVQBtNNQphDmgVQ3tAEX4BZ1VtBQMOQGFGBWUaZV10AREbUWBEUDYQMVQlUgAOQW1DCjQRN1F2DABRRjNFBmATMgdyFm4bUTMCXD8BaVFzGBFEEjMVcDNPPBcqUUBlEjsXVnAZKBg-
     &type=public
     &app_id=06863309
 */
    
    /*
    let titi = "https://api.edamam.com/api/recipes/v2?q=chicken%2C%20rabbit&app_key=2b6469119d2a85f1ca18276aae53b131&_cont=CHcVQBtNNQphDmgVQ3tAEX4BZ1VtBQMOQGFGBWUaZV10AREbUWBEUDYQMVQlUgAOQW1DCjQRN1F2DABRRjNFBmATMgdyFm4bUTMCXD8BaVdzGBFEEjMVcDNPPBcqUUBlEjsXVnAZKBg-&type=public&app_id=06863309"
    let toto = "https://api.edamam.com/api/recipes/v2?q=chicken%2C%20rabbit&app_key=2b6469119d2a85f1ca18276aae53b131&_cont=CHcVQBtNNQphDmgVQ3tAEX4BZ1VtBQMOQGFGBWUaZV10AREbUWBEUDYQMVQlUgAOQW1DCjQRN1F2DABRRjNFBmATMgdyFm4bUTMCXD8BaVFzGBFEEjMVcDNPPBcqUUBlEjsXVnAZKBg-&type=public&app_id=06863309"
    
   */

}
