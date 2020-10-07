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
    private lazy var positionMaxImageName: String = ""
    private lazy var positionMinImageName: String = ""

    private lazy var rollerShutterPositionLabel: UILabel = {
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

    private lazy var rollerShutterPositionSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValueImage = UIImage(named: "\(positionMinImageName)")
        slider.maximumValueImage = UIImage(named: "\(positionMaxImageName)")
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.tintColor = #colorLiteral(red: 0.9092797041, green: 0.7230312228, blue: 0.3200179338, alpha: 1)
        slider.thumbTintColor = #colorLiteral(red: 0.2540504634, green: 0.4793154001, blue: 0.1733816266, alpha: 1)
        slider.isContinuous = true
        slider.addTarget(self,
                         action: #selector(didMovePositionSlider),
                         for: .valueChanged)
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

    private lazy var rollerShutterSaveButton: UIButton = {
        let button = UIButton()
        button.addTarget(self,
                         action: #selector(didTapSaveButton),
                         for: .touchUpInside)
        button.backgroundColor = #colorLiteral(red: 0.2540504634, green: 0.4793154001, blue: 0.1733816266, alpha: 1)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
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
        viewModel.start()
        if let nnn = Int(rollerShutterPositionLabel.text ?? "") {
            rollerShutterPositionSlider.setValue(Float(nnn), animated: true)
        }
    }

    // MARK: - Private Functions

    private func bind(to viewModel: RollerShutterViewModel) {

        viewModel.rollerName = { [weak self] name in
            self?.navigationItem.title = name
        }
        viewModel.rollerDeleteIconName = { [weak self] name in
            self?.deleteIconName = name
        }
        viewModel.rollerPosition = { [weak self] value in
            self?.rollerShutterPositionLabel.text = value
        }
        viewModel.rollerSaveButtonTilte = { [weak self] name in
            self?.rollerShutterSaveButton.setTitle(name, for: .normal)
        }
        viewModel.rollerPositionMaxImageName = { [weak self] name in
            self?.positionMaxImageName = name
        }
        viewModel.rollerPositionMinImageName = { [weak self] name in
            self?.positionMinImageName = name
        }

    }

    // MARK: - Selectors

    @objc private func didTapDeleteButton() {
        viewModel.didPressDeleteIconButton()
    }

    @objc private func didMovePositionSlider() {
        viewModel.didChangeRollerPosition(with: Int(rollerShutterPositionSlider.value))
    }

    @objc private func didTapSaveButton() {
        viewModel.saveNewDeviceSettings()
    }

    // MARK: - Configure UI

    private func setNavigationBar() {
        self.navigationItem.rightBarButtonItem  = deleteButton
    }

    private func setUI() {
        let safeArea = view.safeAreaLayoutGuide
        view.backgroundColor = .white
        view.addSubview(rollerShutterSaveButton)
        rollerShutterSaveButton.anchor(bottom: safeArea.bottomAnchor,
                                       paddingBottom: 15,
                                       width: 100,
                                       height: 60)
        rollerShutterSaveButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true

        view.addSubview(rollerShutterPositionSlider)
        rollerShutterPositionSlider.anchor(left: safeArea.leftAnchor,
                                           right: safeArea.rightAnchor,
                                           paddingLeft: 20, paddingRight: 20)
        rollerShutterPositionSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        rollerShutterPositionSlider.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        view.addSubview(rollerShutterPositionLabel)
        rollerShutterPositionLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        rollerShutterPositionLabel.anchor(right: safeArea.rightAnchor,
                                          paddingRight: 60,
                                          width: 60, height: 60)
    }

}
