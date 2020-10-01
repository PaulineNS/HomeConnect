//
//  ProductTypeFilterTableViewCell.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 28/09/2020.
//

import UIKit

final class ProductTypeFilterTableViewCell: UITableViewCell {

    // MARK: - Public Properties

    static let identifier = "ProductTypeFilterTableViewCell"

    // MARK: - Private Properties

    private let productTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "Type de produit :"
        return label
    }()

    private let productTypeSegmentedControl: UISegmentedControl = {
        let segmentedControlItems: [String] = ["Radiateur", "Volet", "Lumière"]
        let segmentedControl = UISegmentedControl(items: segmentedControlItems)

        segmentedControl.selectedSegmentIndex = 1
        return segmentedControl
    }()

    // MARK: - Public Methods

    public func configure() {
        contentView.addSubview(productTypeLabel)
        contentView.addSubview(productTypeSegmentedControl)

        productTypeLabel.anchor(top: contentView.topAnchor,
                              left: contentView.leftAnchor,
                              paddingTop: 10, paddingLeft: 10, height: 30)
        productTypeSegmentedControl.anchor(top: productTypeLabel.bottomAnchor,
                               left: contentView.leftAnchor,
                               right: contentView.rightAnchor,
                               paddingTop: 10,
                               paddingLeft: 20,
                               paddingRight: 20,
                               height: 30)
    }

}
