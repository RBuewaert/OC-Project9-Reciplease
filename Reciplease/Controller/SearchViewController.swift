//
//  SearchViewController.swift
//  Reciplease
//
//  Created by Romain Buewaert on 09/09/2021.
//

import UIKit

final class SearchViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var ingredientTextView: UITextView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!

    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = "Reciplease"
        navigationItem.backButtonTitle = "Back"
        addButton.layer.cornerRadius = 5
        clearButton.layer.cornerRadius = 5
        searchButton.layer.cornerRadius = 5
    }

    // MARK: - Actions
    @IBAction func tappedAddButton(_ sender: Any) {
        guard let textTapped = textField.text else { return }

        var ingredientsList = [String]()

        if ((textField.text?.contains(",")) != nil) {
            ingredientsList = textTapped.components(separatedBy: ",")
        } else {
            ingredientsList = [textTapped]
        }

        for ingredient in ingredientsList {
            if ingredient.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                continue
            }
            ingredientTextView.text.append("- \(ingredient.trimmingCharacters(in: .whitespacesAndNewlines)) \n")
            textField.text = ""
            textField.resignFirstResponder()
        }
    }

    @IBAction func tappedClearButton(_ sender: Any) {
        ingredientTextView.text = ""
    }

    @IBAction func tappedSearchButton(_ sender: Any) {
        if shouldPerformSegue(withIdentifier: "segueToListTableView", sender: nil) {
        } else {
            presentAlert()
        }
    }

    // MARK: - Private method
    private func extractIngredients() -> String? {
        guard let ingredientsList = ingredientTextView.text?.components(separatedBy: "- ") else { return nil }

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
}

// MARK: - Navigation
extension SearchViewController {
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard ingredientTextView.text != nil && ingredientTextView.text != "" else {
            return false
        }
        return true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToListTableView" {
            guard let vc = segue.destination as? ListTableViewController else { return }
            guard let extractedIngredients = extractIngredients() else { return }
            vc.ingredients = extractedIngredients
        }
    }
}

// MARK: - UIAlertController
extension SearchViewController {
    private func presentAlert() {
        let alertVC = UIAlertController(title: "Error",
                    message: "Add ingredients before launch your research", preferredStyle: .alert)
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
}
