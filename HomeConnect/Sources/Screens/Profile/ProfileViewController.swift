//
//  ProfileViewController.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 24/09/2020.
//

import UIKit

final class ProfileViewController: UIViewController {

    // MARK: - Properties

    private let viewModel: ProfileViewModel
    private lazy var updateIconName: String = ""
    private lazy var closeIconName: String = ""

    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        view.addSubview(profileImageView)

        // Profile Image View
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.anchor(top: view.topAnchor, paddingTop: 100, width: 150, height: 150)

        // User Name Label
        view.addSubview(nameLabel)
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameLabel.anchor(top: profileImageView.bottomAnchor, paddingTop: 10)

        // User Age Label
        view.addSubview(ageLabel)
        ageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        ageLabel.anchor(top: nameLabel.bottomAnchor, paddingTop: 4)

        return view
    }()

    private lazy var adressStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 40
        stackView.addArrangedSubview(streetLabel)
        stackView.addArrangedSubview(cityLabel)
        stackView.addArrangedSubview(countryLabel)
        stackView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        return stackView
    }()

    private let profileImageView: UIImageView = {
        let profileIV = UIImageView()
        return profileIV
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.textColor = #colorLiteral(red: 0.2141337097, green: 0.269574821, blue: 0.3898406625, alpha: 1)
        return label
    }()

    private let ageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.2141337097, green: 0.269574821, blue: 0.3898406625, alpha: 1)
        return label
    }()

    private let streetLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()

    private let cityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()

    private let countryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()

    private let backButtonItem: UIBarButtonItem = {
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        return backButton
    }()

    private lazy var updateProfileButton: UIBarButtonItem = {
        let updateButton = UIBarButtonItem(title: "\(updateIconName)",
                        style: .plain,
                        target: self,
                        action: #selector(didTapUpdateProfileButton))
        return updateButton
    }()

    private lazy var crossButton: UIBarButtonItem = {
        let updateButton = UIBarButtonItem(image: UIImage(named: "\(closeIconName)"),
                        style: .plain,
                        target: self,
                        action: #selector(didTapCrossButton))
        return updateButton
    }()

    // MARK: - Initializer

    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - Lifecycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.start()
        setUI()
        setNavigationBar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind(to: viewModel)
    }

    // MARK: - Privates Methods

    private func bind(to viewModel: ProfileViewModel) {
        viewModel.profileImageName = { [weak self] name in
            self?.profileImageView.image = UIImage(named: name)
        }
        viewModel.userName = { [weak self] name in
            self?.nameLabel.text = name
        }
        viewModel.userAge = { [weak self] age in
            self?.ageLabel.text = age
        }
        viewModel.userStreet = { [weak self] street in
            self?.streetLabel.text = street
        }
        viewModel.userCity = { [weak self] city in
            self?.cityLabel.text = city
        }
        viewModel.userCountry = { [weak self] country in
            self?.countryLabel.text = country
        }
        viewModel.updateIconName = { [weak self] name in
            self?.updateIconName = name
        }
        viewModel.closeIconName = { [weak self] name in
            self?.closeIconName = name
        }
    }

    // MARK: - Selectors

    @objc func didTapUpdateProfileButton() {
        viewModel.didSelectUpdateProfileButton()
    }

    @objc func didTapCrossButton() {
        viewModel.didSelectCrossButton()
    }

    // MARK: - Configure UI

    private func setNavigationBar() {
        self.navigationItem.rightBarButtonItem  = updateProfileButton
        self.navigationItem.leftBarButtonItem = crossButton
        navigationItem.backBarButtonItem = backButtonItem
        navigationController?.navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .black
    }

    private func setUI() {
        let safeArea = view.safeAreaLayoutGuide
        view.backgroundColor = #colorLiteral(red: 0.2141337097, green: 0.269574821, blue: 0.3898406625, alpha: 1)
        view.addSubview(containerView)
        containerView.anchor(top: view.topAnchor,
                             left: safeArea.leftAnchor,
                             right: safeArea.rightAnchor,
                             height: 350)
        view.addSubview(adressStackView)
        adressStackView.anchor(top: containerView.bottomAnchor,
                               left: safeArea.leftAnchor,
                               right: safeArea.rightAnchor,
                               paddingTop: 40)
    }

}
