//
//  LightViewController.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 24/09/2020.
//

import UIKit

final class RollerShutterViewController: UIViewController {

    // MARK: - Properties

    private let viewModel: RollerShutterViewModel
    private lazy var deleteIconName: String = ""

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
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        stackView.addArrangedSubview(rollerShutterOpenLabel)
        stackView.addArrangedSubview(rollerShutterIntensitySlider)
        stackView.addArrangedSubview(rollerShutterClosedLabel)
        return stackView
    }()

    private lazy var rollerShutterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var rollerShutterNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()

    private lazy var rollerShutterOpenLabel: UILabel = {
        let label = UILabel()
        label.text = "Ouvert"
        label.textAlignment = .center
        return label
    }()

    private lazy var rollerShutterClosedLabel: UILabel = {
        let label = UILabel()
        label.text = "Fermé"
        label.textAlignment = .center
        return label
    }()

    private lazy var rollerShutterIntensitySlider: UISlider = {
        let slider = UISlider()
        slider.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2))
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

    init(viewModel: RollerShutterViewModel) {
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

    private func bind(to viewModel: RollerShutterViewModel) {

        viewModel.rollerName = { [weak self] name in
            self?.rollerShutterNameLabel.text = name
        }
        viewModel.rollerImage = { [weak self] image in
            self?.rollerShutterImageView.image = UIImage(named: image)
        }
        viewModel.rollerDeleteIconName = { [weak self] name in
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
        rollerShutterImageView.anchor(top: safeArea.topAnchor,
                           left: safeArea.leftAnchor,
                           paddingTop: 10,
                           paddingLeft: 10,
                           width: 100,
                           height: 100)
        rollerShutterIntensitySlider.translatesAutoresizingMaskIntoConstraints = false
    }

}
