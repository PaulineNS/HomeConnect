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

    private lazy var settingsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 100
        stackView.addArrangedSubview(modeStackView)
        stackView.addArrangedSubview(temperatureStackView)
        stackView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
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

    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 3.0
        label.layer.cornerRadius = 10
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.clipsToBounds = true
        return label
    }()

    private lazy var heaterPlusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "hot"), for: .normal)
        button.addTarget(self, action: #selector(didTapPlusButton), for: .touchUpInside)
        return button
    }()

    private lazy var heaterMinusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "cold"), for: .normal)
        button.addTarget(self, action: #selector(didTapMinusButton), for: .touchUpInside)
        return button
    }()

    private lazy var modeOnLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()

    private lazy var modeOffLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
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
        button.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        button.backgroundColor = .red
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
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

    private func bind(to viewModel: HeaterViewModel) {

        viewModel.heaterName = { [weak self] name in
            self?.navigationItem.title = name
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
        viewModel.heaterSwitchOnText = { [weak self] name in
            self?.modeOnLabel.text = name
        }
        viewModel.heaterSwitchOffText = { [weak self] name in
            self?.modeOffLabel.text = name
        }
        viewModel.heaterSaveButtonTitle = { [weak self] title in
            self?.heaterSaveButton.setTitle(title, for: .normal)
        }
    }

    // MARK: - Selectors

    @objc private func didTapDeleteButton() {
        viewModel.didPressDeleteIconButton()
    }

    @objc private func didTapPlusButton() {
        viewModel.didPressPlusButton()
    }

    @objc private func didTapMinusButton() {
        viewModel.didPressMinusButton()
    }

    @objc private func modeSwitchValueDidChange() {
        viewModel.didChangeModeSwitchValue(withOnvalue: heaterModeSwitch.isOn)
    }

    @objc private func didTapSaveButton() {
        viewModel.saveNewDeviceSettings()
    }

    // MARK: - Configure UI

    private func setNavigationBar() {
        self.navigationItem.rightBarButtonItem  = deleteButton
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .black
    }

    private func setUI() {
        let safeArea = view.safeAreaLayoutGuide
        view.backgroundColor = .white
        view.addSubview(heaterSaveButton)
        view.addSubview(settingsStackView)
        settingsStackView.anchor()
        settingsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        settingsStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        temperatureLabel.anchor(width: 80, height: 80)
        heaterSaveButton.anchor(bottom: safeArea.bottomAnchor,
                                paddingTop: 15,
                                paddingBottom: 15,
                                width: 100, height: 60)
        heaterSaveButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
    }

}
