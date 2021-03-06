//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by Romain Buewaert on 14/09/2021.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var littleView: UIView!
    @IBOutlet weak var bottomLabelsView: UIView!
    @IBOutlet weak var cuisineTypeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var recipeImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        addShadowOnBackground()
        littleView.layer.cornerRadius = 5
        littleView.layer.borderWidth = 1
        littleView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }

    func configure(imageData: Data, title: String, ingredients: String, cuisineType: String, time: Double) {
        recipeImageView.image = UIImage(data: imageData)
        titleLabel.text = title
        ingredientsLabel.text = ingredients
        cuisineTypeLabel.text = cuisineType

        if time > 0 {
            timeLabel.text = "\(time) min"
        } else {
            timeLabel.text = "No Time"
        }
    }

    func configureWithDefaultImage(title: String, ingredients: String, cuisineType: String, time: Double) {
        guard let imageData = UIImage(named: "tableSetFlag")?.pngData() else { return }
        recipeImageView.image = UIImage(data: imageData)
        titleLabel.text = title
        ingredientsLabel.text = ingredients

        cuisineTypeLabel.text = cuisineType

        if time > 0 {
            timeLabel.text = "\(time) min"
        } else {
            timeLabel.text = "No Time"
        }
    }

    private func addShadowOnBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bottomLabelsView.bounds
        gradientLayer.colors = [UIColor.white.withAlphaComponent(0.1).cgColor,
                                UIColor.black.withAlphaComponent(1).cgColor]
        bottomLabelsView.layer.insertSublayer(gradientLayer, at: 0)
    }
}
