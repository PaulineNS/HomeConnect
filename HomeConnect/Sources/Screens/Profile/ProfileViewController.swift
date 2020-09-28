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

    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.addSubview(profileImageView)

        // Profile Image View
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.anchor(top: view.topAnchor, paddingTop: 44, width: 120, height: 88)
        profileImageView.layer.cornerRadius = 120/2

        // User Name Label
        view.addSubview(nameLabel)
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameLabel.anchor(top: profileImageView.bottomAnchor, paddingTop: 30)

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
        stackView.spacing = 10
        stackView.addArrangedSubview(streetLabel)
        stackView.addArrangedSubview(cityLabel)
        stackView.addArrangedSubview(countryLabel)
        return stackView
    }()

    private let profileImageView: UIImageView = {
        let profileIV = UIImageView()
        profileIV.contentMode = .scaleAspectFill
        profileIV.clipsToBounds = true
        profileIV.layer.borderWidth = 3
        profileIV.layer.borderColor = UIColor.white.cgColor
        return profileIV
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.textColor = .white
        return label
    }()

    private let ageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()

    private let streetLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()

    private let cityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()

    private let countryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
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
        viewModel.viewWillAppear()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(containerView)
        containerView.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 250)
        view.addSubview(adressStackView)
        adressStackView.anchor(top: containerView.bottomAnchor,
                               left: view.leftAnchor,
                               bottom: view.bottomAnchor,
                               right: view.rightAnchor,
                               paddingTop: 20,
                               paddingBottom: 200)
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }

    // MARK: - Bindings

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
    }
}
