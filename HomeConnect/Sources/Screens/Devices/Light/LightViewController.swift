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

    private lazy var deleteButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(named: deleteIconName),
                        style: .plain,
                        target: self,
                        action: #selector(didTapDeleteButton))
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
                self?.lightStatusSwitch.setOn(false, animated: true)
                return
            }
            self?.lightStatusSwitch.setOn(true, animated: true)
        }
        viewModel.lightDeleteIconName = { [weak self] name in
            self?.deleteIconName = name
        }
    }

    // MARK: - Selectors

    @objc func didTapDeleteButton() {
        viewModel.didPressDeleteIconButton()
    }

    // MARK: - Configure UI

    private func setNavigationBar() {
        self.navigationItem.rightBarButtonItem  = deleteButton
    }

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
