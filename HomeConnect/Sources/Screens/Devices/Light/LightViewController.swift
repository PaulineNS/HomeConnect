//
//  LightViewController.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 24/09/2020.
//

import UIKit

class LightViewController: UIViewController {

    // MARK: - Properties
    private var topStackView: UIStackView = UIStackView()
    private var bottomStackView = UIStackView()
    private lazy var lightImageView = UIImageView()
    private lazy var lightNameLabel = UILabel()
    private lazy var lightStatusSwitch = UISwitch()
    private lazy var lightIntensitySlider = UISlider()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }

    private func setUI() {
        let safeArea = view.safeAreaLayoutGuide
        view.backgroundColor = .red
        // stackView
        view.addSubview(topStackView)
        topStackView.axis = .horizontal
        topStackView.alignment = .fill
        topStackView.distribution = .equalSpacing
        topStackView.spacing = 10
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        topStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10).isActive = true
        topStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10).isActive = true
        topStackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0).isActive = true

        //lightImgaeView

        topStackView.addArrangedSubview(lightImageView)
        lightImageView.translatesAutoresizingMaskIntoConstraints = false
        lightImageView.image = UIImage(named: "light")
        lightImageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10).isActive = true
        lightImageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10).isActive = true

        lightImageView.contentMode = .scaleAspectFit
        lightImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        lightImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true

        topStackView.addArrangedSubview(lightNameLabel)
        lightNameLabel.text = "hello"
        lightNameLabel.textAlignment = .left

        view.addSubview(bottomStackView)
        bottomStackView.axis = .vertical
        bottomStackView.alignment = .fill
        bottomStackView.distribution = .equalSpacing
        bottomStackView.spacing = 10
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10).isActive = true
        bottomStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10).isActive = true
        bottomStackView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 10).isActive = true
        bottomStackView.addArrangedSubview(lightStatusSwitch)
        lightStatusSwitch.translatesAutoresizingMaskIntoConstraints = false

        bottomStackView.addArrangedSubview(lightIntensitySlider)
        lightIntensitySlider.translatesAutoresizingMaskIntoConstraints = false
    }

}
