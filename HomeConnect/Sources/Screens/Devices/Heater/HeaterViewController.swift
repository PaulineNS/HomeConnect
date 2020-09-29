//
//  LightViewController.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 24/09/2020.
//

import UIKit

final class HeaterViewController: UIViewController {

    // MARK: - Properties

    private let viewModel: HeaterViewModel
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

    private lazy var settingsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.addArrangedSubview(temperatureStackView)
        stackView.addArrangedSubview(modeStackView)
        stackView.addArrangedSubview(heaterSaveButton)
        stackView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        return stackView
    }()

    private lazy var informationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
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
        stackView.addArrangedSubview(heaterModeSwitch)
        stackView.addArrangedSubview(modeOnLabel)
        return stackView
    }()

    private lazy var heaterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var heaterNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()

    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 3.0
        return label
    }()

    private lazy var heaterPlusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "plusButton"), for: .normal)
        button.addTarget(self, action: #selector(didTapPlusButton), for: .touchUpInside)
        return button
    }()

    private lazy var heaterMinusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "minusButton"), for: .normal)
        button.addTarget(self, action: #selector(didTapMinusButton), for: .touchUpInside)
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

    private lazy var heaterModeSwitch: UISwitch = {
        let modeSwitch = UISwitch()
        modeSwitch.addTarget(self, action: #selector(modeSwitchValueDidChange), for: .valueChanged)

        return modeSwitch
    }()

    private lazy var deleteButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(named: deleteIconName),
                        style: .plain,
                        target: self,
                        action: #selector(didTapDeleteButton))
        return button
    }()

    private lazy var heaterSaveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Enregistrer", for: .normal)
        button.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        button.backgroundColor = .red
        return button
    }()

    // MARK: - Initializer

    init(viewModel: HeaterViewModel) {
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
    }

    // MARK: - Private Functions

    // MARK: - Bindings

    private func bind(to viewModel: HeaterViewModel) {

        viewModel.heaterName = { [weak self] name in
            self?.heaterNameLabel.text = name
        }
        viewModel.heaterImage = { [weak self] image in
            self?.heaterImageView.image = UIImage(named: image)
        }
        viewModel.heaterMode = { [weak self] mode in
            guard mode == "ON" else {
                self?.heaterModeSwitch.setOn(false, animated: true)
                return
            }
            self?.heaterModeSwitch.setOn(true, animated: true)
        }
        viewModel.heaterTemperature = { [weak self] temperature in
            self?.temperatureLabel.text = temperature
        }
        viewModel.heaterDeleteIconName = { [weak self] name in
            self?.deleteIconName = name
        }

    }

    // MARK: - Selectors

    @objc func didTapDeleteButton() {
        viewModel.didPressDeleteIconButton()
    }

    @objc func didTapPlusButton() {
        viewModel.didPressPlusButton()
    }

    @objc func didTapMinusButton() {
        viewModel.didPressMinusButton()
    }

    @objc func modeSwitchValueDidChange() {
        viewModel.didChangeModeSwitchValue(withOnvalue: heaterModeSwitch.isOn)
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
        heaterImageView.anchor(width: 50,
                           height: 50)

    }

}
