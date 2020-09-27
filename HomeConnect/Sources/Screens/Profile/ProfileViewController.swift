//
//  ProfileViewController.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 24/09/2020.
//

import UIKit

class ProfileViewController: UIViewController {

    // MARK: - Properties
    private let viewModel: ProfileViewModel

    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainBlue

        view.addSubview(profileImageView)
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.anchor(top: view.topAnchor, paddingTop: 44, width: 120, height: 88)
        profileImageView.layer.cornerRadius = 120/2

        view.addSubview(nameLabel)
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameLabel.anchor(top: profileImageView.bottomAnchor, paddingTop: 12)

        view.addSubview(ageLabel)
        ageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        ageLabel.anchor(top: nameLabel.bottomAnchor, paddingTop: 4)

        return view
    }()

    let profileImageView: UIImageView = {
        let profileIV = UIImageView()
//        profileIV.image = UIImage(named: "light")
        profileIV.contentMode = .scaleAspectFill
        profileIV.clipsToBounds = true
        profileIV.layer.borderWidth = 3
        profileIV.layer.borderColor = UIColor.white.cgColor
        return profileIV
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
//        label.text = "Pauline Nomballais"
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.textColor = .white
        return label
    }()

    let ageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
//        label.text = "29 ans"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
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
        containerView.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 300)

        bind(to: viewModel)
        viewModel.viewDidLoad()
    }

    private func bind(to viewModel: ProfileViewModel) {

        viewModel.profileImageName = { [weak self] name in
            self?.profileImageView.image = UIImage(named: name)
        }
        viewModel.userName = { [weak self] name in
            self?.nameLabel.text = name
        }
        viewModel.userCity = { [weak self] city in
            self?.ageLabel.text = city
        }
    }

}

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }

    static let mainBlue = UIColor.rgb(red: 0,
                                      green: 150,
                                      blue: 255)

}

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat? = 0,
                paddingLeft: CGFloat? = 0,
                paddingBottom: CGFloat? = 0,
                paddingRight: CGFloat? = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil) {
        translatesAutoresizingMaskIntoConstraints = false

        if let top = top, let paddingTop = paddingTop {
                topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }

        if let left = left, let paddingLeft = paddingLeft {
                leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }

        if let bottom = bottom, let paddingBottom = paddingBottom {
                bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }

        if let right = right, let paddingRight = paddingRight {
                rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }

        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }

        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
