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
    private lazy var heaterPlusButtonImageName: String = ""
    private lazy var heaterMinButtonImageName: String = ""

    private lazy var temperatureVieww: UIView = {
        let view = UIView()
        view.addSubview(heaterMinusButton)
        heaterMinusButton.anchor(top: view.topAnchor, bottom: view.bottomAnchor)
        heaterMinusButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        view.addSubview(temperatureLabel)
        temperatureLabel.anchor(top: view.topAnchor,
                               left: heaterMinusButton.rightAnchor,
                               bottom: view.bottomAnchor,
                               paddingLeft: 15)
        temperatureLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        temperatureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        view.addSubview(heaterPlusButton)
        heaterPlusButton.anchor(top: view.topAnchor,
                           left: temperatureLabel.rightAnchor,
                           bottom: view.bottomAnchor,
                           paddingLeft: 15)
        heaterPlusButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        return view
    }()

    private lazy var modeVieww: UIView = {
        let view = UIView()
        view.addSubview(modeOffLabel)
        modeOffLabel.anchor(top: view.topAnchor, bottom: view.bottomAnchor)
        modeOffLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        view.addSubview(heaterModeSwitch)
        heaterModeSwitch.anchor(top: view.topAnchor,
                               left: modeOffLabel.rightAnchor,
                               bottom: view.bottomAnchor,
                               paddingLeft: 15)
        heaterModeSwitch.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        heaterModeSwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        view.addSubview(modeOnLabel)
        modeOnLabel.anchor(top: view.topAnchor,
                           left: heaterModeSwitch.rightAnchor,
                           bottom: view.bottomAnchor,
                           paddingLeft: 15)
        modeOnLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        return view
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
        button.setImage(UIImage(named: "\(heaterPlusButtonImageName)"), for: .normal)
        button.addTarget(self, action: #selector(didTapPlusButton), for: .touchUpInside)
        return button
    }()

    private lazy var heaterMinusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "\(heaterMinButtonImageName)"), for: .normal)
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
        modeSwitch.onTintColor = #colorLiteral(red: 0.307313025, green: 0.70265311, blue: 0.7067130804, alpha: 1)
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
        button.backgroundColor = #colorLiteral(red: 0.684643507, green: 0.785309732, blue: 0.172726661, alpha: 1)
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
        viewModel.start()
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
        viewModel.heaterPlusButtonImageName = { [weak self] name in
            self?.heaterPlusButtonImageName = name
        }
        viewModel.heaterMinButtonImageName = { [weak self] name in
            self?.heaterMinButtonImageName = name
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

        view.addSubview(modeVieww)

        modeVieww.anchor(top: safeArea.topAnchor, paddingTop: 70, width: 100, height: 30)
        modeVieww.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        view.addSubview(temperatureVieww)
        temperatureVieww.anchor(width: 200, height: 80)
        temperatureVieww.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        temperatureVieww.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor).isActive = true

        temperatureLabel.anchor(width: 80, height: 80)
        heaterSaveButton.anchor(bottom: safeArea.bottomAnchor,
                                paddingTop: 15,
                                paddingBottom: 15,
                                width: 100, height: 60)
        heaterSaveButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
    }

}
