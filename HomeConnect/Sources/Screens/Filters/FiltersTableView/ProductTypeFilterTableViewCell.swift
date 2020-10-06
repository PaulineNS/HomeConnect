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
    weak var delegate: ProductTypeFilterTableViewCellDelegate?

    // MARK: - Private Properties

    private let productTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "Type de produit :"
        return label
    }()

    let productTypeSegmentedControl: UISegmentedControl = {
        let segmentedControlItems: [String] = ["Radiateur", "Volet", "Lumière"]
        let segmentedControl = UISegmentedControl(items: segmentedControlItems)
//        segmentedControl.addTarget(self, action: #selector(didChangeSegmentedControlValue), for: .valueChanged)
//        segmentedControl.selectedSegmentIndex = 1
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

    func getSegmentedControlIndex() -> Int {
        let index = productTypeSegmentedControl.selectedSegmentIndex
        switch index {
        case 0:
            return 1
        case 1:
            return 2
        case 2:
            return 3
        default:
            return 0
        }
    }

    @objc func didChangeSegmentedControlValue() {
        productTypeSegmentedControl.selectedSegmentIndex = productTypeSegmentedControl.selectedSegmentIndex
        delegate?.didChangeSegmentedControlValue()
    }

}

protocol ProductTypeFilterTableViewCellDelegate: class {
    func didChangeSegmentedControlValue()
}
