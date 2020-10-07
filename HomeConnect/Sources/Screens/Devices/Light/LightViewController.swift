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
    private lazy var intensityMaxImageName: String = ""
    private lazy var intensityMinImageName: String = ""

    private lazy var lightModeSwitch: UISwitch = {
        let modeSwitch = UISwitch()
        modeSwitch.onTintColor = #colorLiteral(red: 0.307313025, green: 0.70265311, blue: 0.7067130804, alpha: 1)
        modeSwitch.addTarget(self, action: #selector(modeSwitchValueDidChange), for: .valueChanged)
        return modeSwitch
    }()

    private lazy var lightIntensityLabel: UILabel = {
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

    private lazy var lightIntensitySlider: UISlider = {
        let slider = UISlider()
        slider.minimumValueImage = UIImage(named: "\(intensityMinImageName)")
        slider.maximumValueImage = UIImage(named: "\(intensityMaxImageName)")
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.tintColor = #colorLiteral(red: 0.9092797041, green: 0.7230312228, blue: 0.3200179338, alpha: 1)
        slider.thumbTintColor = #colorLiteral(red: 0.307313025, green: 0.70265311, blue: 0.7067130804, alpha: 1)
        slider.isContinuous = true
        slider.addTarget(self, action: #selector(didMoveIntensitySlider), for: .valueChanged)
        return slider
    }()

    private lazy var modeVieww: UIView = {
        let view = UIView()
        view.addSubview(modeOffLabel)
        modeOffLabel.anchor(top: view.topAnchor, bottom: view.bottomAnchor)
        modeOffLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        view.addSubview(lightModeSwitch)
        lightModeSwitch.anchor(top: view.topAnchor,
                               left: modeOffLabel.rightAnchor,
                               bottom: view.bottomAnchor,
                               paddingLeft: 15)
        lightModeSwitch.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        lightModeSwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        view.addSubview(modeOnLabel)
        modeOnLabel.anchor(top: view.topAnchor,
                           left: lightModeSwitch.rightAnchor,
                           bottom: view.bottomAnchor,
                           paddingLeft: 15)
        modeOnLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        return view
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

    private lazy var deleteButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(named: deleteIconName),
                        style: .plain,
                        target: self,
                        action: #selector(didTapDeleteButton))
        return button
    }()

    private lazy var lightSaveButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        button.backgroundColor = #colorLiteral(red: 0.307313025, green: 0.70265311, blue: 0.7067130804, alpha: 1)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
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
        viewModel.start()
        if let intensityValue = Int(lightIntensityLabel.text ?? "") {
            lightIntensitySlider.setValue(Float(intensityValue), animated: true)
        }

    }

    // MARK: - Private Functions

    private func bind(to viewModel: LightViewModel) {
        viewModel.lightName = { [weak self] name in
            self?.navigationItem.title = name
        }
        viewModel.lightMode = { [weak self] mode in
            switch mode {
            case .off:
                self?.lightModeSwitch.setOn(false, animated: true)
            case .on:
                self?.lightModeSwitch.setOn(true, animated: true)
            }
        }
        viewModel.lightDeleteIconName = { [weak self] name in
            self?.deleteIconName = name
        }
        viewModel.lightIntensity = { [weak self] value in
            self?.lightIntensityLabel.text = value
        }
        viewModel.lightOnSwitchName = { [weak self] name in
            self?.modeOnLabel.text = name
        }
        viewModel.lightOffSwitchName = { [weak self] name in
            self?.modeOffLabel.text = name
        }
        viewModel.lightSaveButtonTilte = { [weak self] name in
            self?.lightSaveButton.setTitle(name, for: .normal)
        }
        viewModel.lightIntensityMaxImageName = { [weak self] name in
            self?.intensityMaxImageName = name
        }
        viewModel.lightIntensityMinImageName = { [weak self] name in
            self?.intensityMinImageName = name
        }
    }

    // MARK: - Selectors

    @objc private func didTapDeleteButton() {
        viewModel.didPressDeleteIconButton()
    }

    @objc private func didMoveIntensitySlider() {
        viewModel.didChangeLightIntensity(with: Int(lightIntensitySlider.value))
    }

    @objc private func modeSwitchValueDidChange() {
        viewModel.didChangeModeSwitchValue(withOnvalue: lightModeSwitch.isOn)
        if let nnn = Int(lightIntensityLabel.text ?? "") {
            lightIntensitySlider.setValue(Float(nnn), animated: true)
        }
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
        //Light save button
        view.addSubview(lightSaveButton)
        lightSaveButton.anchor(bottom: safeArea.bottomAnchor,
                               paddingBottom: 15,
                               width: 100,
                               height: 60)
        lightSaveButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true

        //Light intensity slider
        view.addSubview(lightIntensitySlider)
        lightIntensitySlider.anchor(left: safeArea.leftAnchor,
                                    right: safeArea.rightAnchor,
                                    paddingLeft: 20, paddingRight: 20)
        lightIntensitySlider.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lightIntensitySlider.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        //Light intensity label
        view.addSubview(lightIntensityLabel)
        lightIntensityLabel.anchor(top: lightIntensitySlider.bottomAnchor,
                                   paddingTop: 20,
                                   width: 60,
                                   height: 60)
        lightIntensityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        //Mode view
        view.addSubview(modeVieww)

        modeVieww.anchor(top: safeArea.topAnchor, paddingTop: 70, width: 100, height: 30)
        modeVieww.centerXAnchor.constraint(equalTo: lightIntensitySlider.centerXAnchor).isActive = true
    }

}
