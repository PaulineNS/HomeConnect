//
//  FiltersViewController.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 24/09/2020.
//

import UIKit

final class FiltersViewController: UIViewController {

    // MARK: - Properties

    private lazy var source: FiltersDataSource = FiltersDataSource()
    private let viewModel: FiltersViewModel
    private lazy var searchIconTitleName: String = ""
    private lazy var closeIconName: String = ""

    private let tableView: UITableView = {
        let table = UITableView()
        table.tableFooterView = UIView()
        table.register(ProductTypeFilterTableViewCell.self,
                       forCellReuseIdentifier: ProductTypeFilterTableViewCell.identifier)
        table.register(IntensityFilterTableViewCell.self,
                       forCellReuseIdentifier: IntensityFilterTableViewCell.identifier)
        table.register(ModeFilterTableViewCell.self,
                       forCellReuseIdentifier: ModeFilterTableViewCell.identifier)
        table.register(PositionFilterTableViewCell.self,
                       forCellReuseIdentifier: PositionFilterTableViewCell.identifier)
        table.register(TemperatureFilterTableViewCell.self,
                       forCellReuseIdentifier: TemperatureFilterTableViewCell.identifier)
        return table
    }()

    private lazy var searchButton: UIBarButtonItem = {
        let updateButton = UIBarButtonItem(title: "\(searchIconTitleName)",
                        style: .plain,
                        target: self,
                        action: #selector(didTapSearchButton))
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

    init(viewModel: FiltersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - Lifecycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        view.addSubview(tableView)
        tableView.delegate = source
        tableView.dataSource = source
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    // MARK: - Selectors

    @objc func didTapSearchButton() {
        viewModel.searchDeviceWithFilters()
    }

    @objc func didTapCrossButton() {
        viewModel.didSelectCrossButton()
    }

    // MARK: - Configure UI

    private func setNavigationBar() {
        self.navigationItem.rightBarButtonItem  = searchButton
        self.navigationItem.leftBarButtonItem = crossButton
        navigationController?.navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .black

    }

    private func bind(to viewModel: FiltersViewModel) {
        viewModel.searchIconName = { [weak self] title in
            self?.searchIconTitleName = title
        }
        viewModel.closeIconName = { [weak self] name in
            self?.closeIconName = name
        }
    }
}
