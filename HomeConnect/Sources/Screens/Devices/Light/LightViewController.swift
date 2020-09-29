//
//  LightViewController.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 24/09/2020.
//

import UIKit

final class LightViewController: UIViewController {

    // MARK: - Properties

    private let viewModel: LightViewModel

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
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var lightNameLabel: UILabel = {
        let label = UILabel()
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

    // MARK: - Initializer

    init(viewModel: LightViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - Lifecycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }

    // MARK: - Private Functions

    // MARK: - Bindings

    private func bind(to viewModel: LightViewModel) {

        viewModel.lightName = { [weak self] name in
            self?.lightNameLabel.text = name
        }
        viewModel.lightImage = { [weak self] image in
            self?.lightImageView.image = UIImage(named: image)

        }
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
