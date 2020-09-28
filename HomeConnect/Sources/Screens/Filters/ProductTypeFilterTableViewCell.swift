//
//  ProductTypeFilterTableViewCell.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 28/09/2020.
//

import UIKit

class ProductTypeFilterTableViewCell: UITableViewCell {

    static let identifier = "ProductTypeFilterTableViewCell"

    private let productTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "Type de produit :"
        return label
    }()

    public func configure() {
        contentView.addSubview(productTypeLabel)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        productTypeLabel.frame = CGRect(x: 105, y: 5, width: contentView.frame.size.width, height: 100)
    }

}
