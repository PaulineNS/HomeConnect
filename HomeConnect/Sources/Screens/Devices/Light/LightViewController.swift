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
    private lazy var deleteIconName: String = ""

    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        stackView.addArrangedSubview(informationStackView)
        stackView.addArrangedSubview(settingsStackView)
        return stackView
    }()

    private lazy var informationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .yellow
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.addArrangedSubview(lightImageView)
        stackView.addArrangedSubview(lightNameLabel)
        return stackView
    }()

    private lazy var settingsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .green
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.addArrangedSubview(lightModeSwitch)
        stackView.addArrangedSubview(lightIntensityLabel)
        stackView.addArrangedSubview(lightIntensitySlider)
        stackView.addArrangedSubview(lightSaveButton)
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

    private lazy var lightModeSwitch: UISwitch = {
        let modeSwitch = UISwitch()
        modeSwitch.addTarget(self, action: #selector(modeSwitchValueDidChange), for: .valueChanged)
        return modeSwitch
    }()

    private lazy var lightIntensityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()

    private lazy var lightIntensitySlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.tintColor = .red
        slider.thumbTintColor = .black
        slider.isContinuous = true
        slider.addTarget(self, action: #selector(didMoveIntensitySlider), for: .valueChanged)
        return slider
    }()

    private lazy var deleteButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(named: deleteIconName),
                        style: .plain,
                        target: self,
                        action: #selector(didTapDeleteButton))
        return button
    }()

    private lazy var lightSaveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Enregistrer", for: .normal)
        button.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        button.backgroundColor = .red
        return button
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
        setUI()
        setNavigationBar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind(to: viewModel)
        viewModel.viewDidLoad()
        if let nnn = Int(lightIntensityLabel.text ?? "") {
            lightIntensitySlider.setValue(Float(nnn), animated: true)
        }

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
        viewModel.lightMode = { [weak self] mode in
            guard mode == "ON" else {
                self?.lightModeSwitch.setOn(false, animated: true)
                return
            }
            self?.lightModeSwitch.setOn(true, animated: true)
        }
        viewModel.lightDeleteIconName = { [weak self] name in
            self?.deleteIconName = name
        }
        viewModel.lightIntensity = { [weak self] value in
            self?.lightIntensityLabel.text = value
        }
    }

    // MARK: - Selectors

    @objc func didTapDeleteButton() {
        viewModel.didPressDeleteIconButton()
    }

    @objc func didMoveIntensitySlider() {
        viewModel.didChangeLightIntensity(with: Int(lightIntensitySlider.value))
    }

    @objc func modeSwitchValueDidChange() {
        viewModel.didChangeModeSwitchValue(withOnvalue: lightModeSwitch.isOn)
        if let nnn = Int(lightIntensityLabel.text ?? "") {
            lightIntensitySlider.setValue(Float(nnn), animated: true)
        }
    }

    @objc func didTapSaveButton() {
        viewModel.saveNewDeviceSettings()
    }

    // MARK: - Configure UI

    private func setNavigationBar() {
        self.navigationItem.rightBarButtonItem  = deleteButton
    }

    private func setUI() {
        let safeArea = view.safeAreaLayoutGuide
        view.backgroundColor = .white
        view.addSubview(containerStackView)
        containerStackView.anchor(top: safeArea.topAnchor,
                                  left: safeArea.leftAnchor,
                                  bottom: safeArea.bottomAnchor,
                                  right: safeArea.rightAnchor)
        lightImageView.anchor(width: 50,
                           height: 50)
    }

}
