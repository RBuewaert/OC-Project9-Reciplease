//
//  SearchViewController.swift
//  Reciplease
//
//  Created by Romain Buewaert on 09/09/2021.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var ingredientTextView: UITextView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addButton.layer.cornerRadius = 5
        clearButton.layer.cornerRadius = 5
        searchButton.layer.cornerRadius = 5
    }

    @IBAction func tappedAddButton(_ sender: Any) {
        guard textField.text != nil else { return }

        var ingredientsList = [String]()

        if ((textField.text?.contains(",")) != nil) {
            ingredientsList = (textField.text?.components(separatedBy: ","))!
        } else {
            ingredientsList = [textField.text!]
        }

        for ingredient in ingredientsList {
            if ingredient.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                continue
            }
            ingredientTextView.text.append("- \(ingredient.trimmingCharacters(in: .whitespacesAndNewlines)) \n")
        }
    }
    
    @IBAction func tappedClearButton(_ sender: Any) {
        ingredientTextView.text = ""
    }

    @IBAction func tappedSearchButton(_ sender: Any) {
        if shouldPerformSegue(withIdentifier: "segueToListTableView", sender: nil) {
            print("research")
        } else {
            presentAlert()
        }
    }

    private func extractIngredients() -> String {
        var ingredientsList = [String]()
        ingredientsList = (ingredientTextView.text?.components(separatedBy: "- "))!
        print(ingredientsList)

        var ingredients = ""
        for ingredient in ingredientsList {
            if ingredient == ingredientsList.last {
                ingredients.append(ingredient.trimmingCharacters(in: .whitespacesAndNewlines))
            } else {
                ingredients.append("\(ingredient.trimmingCharacters(in: .whitespacesAndNewlines)), ")
            }
        }
        ingredients.removeFirst(2)
        return ingredients
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard ingredientTextView.text != nil && ingredientTextView.text != "" else {
//            presentAlert()
            return false
        }
        return true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToListTableView" {
            let vc = segue.destination as! ListTableViewController
            vc.ingredients = extractIngredients()
        }
    }

    private func presentAlert(){
        let alertVC = UIAlertController(title: "Error", message: "Add ingredients before launch your research", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertVC.addAction(action)
        present(alertVC, animated: true, completion: nil)
    }
}

// MARK: - Keyboard
extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
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


// MARK: - Navigation
extension SearchViewController {
    
    
}
