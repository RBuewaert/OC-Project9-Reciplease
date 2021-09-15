//
//  ListTableViewController.swift
//  Reciplease
//
//  Created by Romain Buewaert on 13/09/2021.
//

import UIKit

class ListTableViewController: UITableViewController {
    var ingredients = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 200
        
        RecipeService.shared.getRecipe(ingredients: ingredients) { succes in
            if succes {
                self.tableView.reloadData()
                print(self.ingredients)
                print("NBRE OF RECIPE: \(RecipeService.recipeList.list.count)")
            } else {
                self.alertErrorMessage()
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
        return RecipeService.recipeList.list.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }

        let recipe = RecipeService.recipeList.list[indexPath.row]
        
        guard recipe.image != nil else {
            //
            return cell
        }
        
        RecipeService.shared.getImage(url: recipe.image!) { succes, image in
            if succes {
                guard image != nil else { return }
                cell.configure(picture: image!, title: recipe.title, ingredients: recipe.ingredientList, note: recipe.yield, time: recipe.totalTime)
            } else {
//                cell.configure(picture: Data, title: recipe.title, ingredients: recipe.ingredientList, note: recipe.yield, time: recipe.totalTime)
            }
        }
        return cell
    }
    
    // MARK: - UIAlertController
    private func alertErrorMessage() {
        let alertVC = UIAlertController(title: "Error!", message: "Download failed",
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

}
