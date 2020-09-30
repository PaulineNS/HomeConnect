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

    private lazy var rollerShutterPositionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()

    private lazy var rollerShutterPositionSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValueImage = #imageLiteral(resourceName: "close")
        slider.maximumValueImage = #imageLiteral(resourceName: "open")
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.tintColor = .red
        slider.thumbTintColor = .black
        slider.isContinuous = true
        slider.addTarget(self, action: #selector(didMovePositionSlider), for: .valueChanged)
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
        button.setTitle("Enregistrer", for: .normal)
        button.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        button.backgroundColor = .red
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
        viewModel.viewDidLoad()
        if let nnn = Int(rollerShutterPositionLabel.text ?? "") {
            rollerShutterPositionSlider.setValue(Float(nnn), animated: true)
        }
    }

    // MARK: - Private Functions

    // MARK: - Bindings

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

    }

    // MARK: - Selectors

    @objc func didTapDeleteButton() {
        viewModel.didPressDeleteIconButton()
    }

    @objc func didMovePositionSlider() {
        viewModel.didChangeRollerPosition(with: Int(rollerShutterPositionSlider.value))
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
        view.addSubview(rollerShutterSaveButton)
        rollerShutterSaveButton.anchor(bottom: safeArea.bottomAnchor, paddingBottom: 15, width: 100, height: 60)
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
