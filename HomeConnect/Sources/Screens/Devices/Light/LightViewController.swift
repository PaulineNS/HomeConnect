//
//  LightViewController.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 24/09/2020.
//

import UIKit

final class LightViewController: UIViewController {

    // MARK: - Properties

    private lazy var informationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.addArrangedSubview(lightImageView)
        stackView.addArrangedSubview(lightNameLabel)
        return stackView
    }()

    private lazy var settingsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.addArrangedSubview(lightStatusSwitch)
        stackView.addArrangedSubview(lightIntensitySlider)
        return stackView
    }()

    private lazy var lightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "light")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var lightNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Lumière"
        label.textAlignment = .left
        return label
    }()

    private lazy var lightStatusSwitch: UISwitch = {
        let statusSwitch = UISwitch()
        return statusSwitch
    }()

    private lazy var lightIntensitySlider: UISlider = {
        let slider = UISlider()
        return slider
    }()

    // MARK: - Lifecycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }

    // MARK: - Configure UI

    private func setUI() {
        let safeArea = view.safeAreaLayoutGuide
        view.backgroundColor = .white
        view.addSubview(informationStackView)
        view.addSubview(settingsStackView)

        informationStackView.anchor(top: safeArea.topAnchor,
                                    left: safeArea.leftAnchor,
                                    right: safeArea.rightAnchor,
                                    paddingLeft: 10,
                                    paddingRight: 10)
        settingsStackView.anchor(top: informationStackView.bottomAnchor,
                                 left: safeArea.leftAnchor,
                                 bottom: safeArea.bottomAnchor,
                                 right: safeArea.rightAnchor,
                                 paddingTop: 10,
                                 paddingLeft: 10,
                                 paddingBottom: 10,
                                 paddingRight: 10)
        lightImageView.anchor(top: safeArea.topAnchor,
                           left: safeArea.leftAnchor,
                           paddingTop: 10,
                           paddingLeft: 10,
                           width: 100,
                           height: 100)
        lightStatusSwitch.translatesAutoresizingMaskIntoConstraints = false
        lightIntensitySlider.translatesAutoresizingMaskIntoConstraints = false
    }

}
