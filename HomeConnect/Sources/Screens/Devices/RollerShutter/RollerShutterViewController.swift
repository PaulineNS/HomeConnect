//
//  LightViewController.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 24/09/2020.
//

import UIKit

final class RollerShutterViewController: UIViewController {

    // MARK: - Properties

    private lazy var informationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.addArrangedSubview(rollerShutterImageView)
        stackView.addArrangedSubview(rollerShutterNameLabel)
        return stackView
    }()

    private lazy var settingsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.addArrangedSubview(rollerShutterStatusSwitch)
        stackView.addArrangedSubview(rollerShutterIntensitySlider)
        return stackView
    }()

    private lazy var rollerShutterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "rollerShutter")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var rollerShutterNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Volet"
        label.textAlignment = .left
        return label
    }()

    private lazy var rollerShutterStatusSwitch: UISwitch = {
        let statusSwitch = UISwitch()
        return statusSwitch
    }()

    private lazy var rollerShutterIntensitySlider: UISlider = {
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
        rollerShutterImageView.anchor(top: safeArea.topAnchor,
                           left: safeArea.leftAnchor,
                           paddingTop: 10,
                           paddingLeft: 10,
                           width: 100,
                           height: 100)
        rollerShutterStatusSwitch.translatesAutoresizingMaskIntoConstraints = false
        rollerShutterIntensitySlider.translatesAutoresizingMaskIntoConstraints = false
    }

}
