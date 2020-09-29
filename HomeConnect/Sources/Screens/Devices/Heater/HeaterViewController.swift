//
//  LightViewController.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 24/09/2020.
//

import UIKit

final class HeaterViewController: UIViewController {

    // MARK: - Properties
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 400
        stackView.addArrangedSubview(temperatureStackView)
        stackView.addArrangedSubview(modeStackView)
        stackView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        return stackView
    }()

    private lazy var informationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.addArrangedSubview(heaterImageView)
        stackView.addArrangedSubview(heaterNameLabel)
        return stackView
    }()

    private lazy var temperatureStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.addArrangedSubview(heaterMinusButton)
        stackView.addArrangedSubview(temperatureLabel)
        stackView.addArrangedSubview(heaterPlusButton)
        return stackView
    }()

    private lazy var modeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        stackView.addArrangedSubview(modeOffLabel)
        stackView.addArrangedSubview(heaterStatusSwitch)
        stackView.addArrangedSubview(modeOnLabel)
        return stackView
    }()

    private lazy var heaterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "heater")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var heaterNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Radiateur"
        label.textAlignment = .left
        return label
    }()

    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "10 °C"
        label.textAlignment = .center
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 3.0
        return label
    }()

    private lazy var heaterPlusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "plusButton"), for: .normal)
        return button
    }()

    private lazy var heaterMinusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "minusButton"), for: .normal)
        return button
    }()

    private lazy var modeOnLabel: UILabel = {
        let label = UILabel()
        label.text = "On"
        label.textAlignment = .center
        return label
    }()

    private lazy var modeOffLabel: UILabel = {
        let label = UILabel()
        label.text = "Off"
        label.textAlignment = .center
        return label
    }()

    private lazy var heaterStatusSwitch: UISwitch = {
        let statusSwitch = UISwitch()
        return statusSwitch
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
        view.addSubview(containerStackView)

        containerStackView.anchor(top: informationStackView.bottomAnchor,
                                  left: safeArea.leftAnchor,
                                  right: safeArea.rightAnchor,
                                  paddingTop: 20,
                                  paddingLeft: 15, paddingRight: 15)

        informationStackView.anchor(top: safeArea.topAnchor,
                                    left: safeArea.leftAnchor,
                                    right: safeArea.rightAnchor,
                                    paddingTop: 10,
                                    paddingLeft: 10,
                                    paddingRight: 10)

        temperatureStackView.anchor(top: containerStackView.topAnchor,
                             left: containerStackView.leftAnchor,
                             right: containerStackView.rightAnchor,
                             paddingTop: 100,
                             paddingLeft: 50,
                             paddingRight: 50)
        modeStackView.anchor(top: temperatureStackView.bottomAnchor,
                                    left: containerStackView.leftAnchor,
                                    right: containerStackView.rightAnchor,
                                    paddingTop: 100,
                                    paddingLeft: 80,
                                    paddingRight: 80)

        heaterImageView.anchor(width: 100,
                           height: 100)
        temperatureLabel.anchor(height: 50)
        modeOnLabel.anchor(height: 50)
        modeOffLabel.anchor(height: 50)
        heaterPlusButton.anchor(height: 50)
        heaterMinusButton.anchor(height: 50)
        heaterMinusButton.translatesAutoresizingMaskIntoConstraints = false
        heaterPlusButton.translatesAutoresizingMaskIntoConstraints = false
        heaterStatusSwitch.translatesAutoresizingMaskIntoConstraints = false
        modeOnLabel.translatesAutoresizingMaskIntoConstraints = false
        modeOffLabel.translatesAutoresizingMaskIntoConstraints = false
    }

}
