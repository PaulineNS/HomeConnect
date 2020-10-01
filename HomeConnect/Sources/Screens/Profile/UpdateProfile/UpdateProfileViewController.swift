//
//  UpdateProfileViewController.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 29/09/2020.
//

import UIKit

class UpdateProfileViewController: UIViewController {

    // MARK: - Properties

    private lazy var source: UpdateProfileDataSource = UpdateProfileDataSource()
    private let viewModel: UpdateProfileViewModel

    let textFieldTypeData = ["Prénom :", "Nom :",
                             "N° de rue :",
                             "Nom de Rue :",
                             "Code Postal :",
                             "Ville :",
                             "Pays :",
                             "Age :"]

    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .systemGray5
        table.register(UpdateProfileTableViewCell.self,
                       forCellReuseIdentifier: UpdateProfileTableViewCell.identifier)
        table.separatorStyle = .none
        return table
    }()

    private lazy var saveInformationsButton: UIBarButtonItem = {
        let updateButton = UIBarButtonItem(title: "Enregistrer",
                        style: .plain,
                        target: self,
                        action: #selector(didTapUpdateProfileButton))
        return updateButton
    }()

    private let backButtonItem: UIBarButtonItem = {
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        return backButton
    }()

    // MARK: - Initializer

    init(viewModel: UpdateProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - Lifecycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
        setNavigationBar()
        setTableView()
        tableView.delegate = source
        tableView.dataSource = source
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        bind(to: viewModel)
    }

    private func bind(to viewModel: UpdateProfileViewModel) {
        viewModel.userDisplayed = { [weak self] users in
            self?.source.updateCell(with: users)
            self?.tableView.reloadData()
        }
    }

    // MARK: - Selectors

    @objc func didTapUpdateProfileButton() {
        viewModel.saveNewUserInformations(with: source.arrayOfCells)
    }

    // MARK: - Configure UI

    private func setNavigationBar() {
        navigationItem.backBarButtonItem = backButtonItem
        navigationItem.rightBarButtonItem  = saveInformationsButton
    }

    private func setTableView() {
        view.addSubview(tableView)
        tableView.anchor(top: view.topAnchor,
                         left: view.leftAnchor,
                         bottom: view.bottomAnchor,
                         right: view.rightAnchor)
    }
}

// MARK: - TextFieldData

enum TextFieldData: Int {

    case firstNameTextField = 0
    case lastNameTextField
    case streetNumberTextField
    case streetNameTextField
    case postalCodeTextField
    case cityTextField
    case countryTextField

}
