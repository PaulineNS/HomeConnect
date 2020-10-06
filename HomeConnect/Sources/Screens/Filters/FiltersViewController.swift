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

    private let productTypeSegmentedControl: UISegmentedControl = {
        let segmentedControlItems: [String] = ["heater_object".localized,
                                               "roller_shutter_object".localized,
                                               "light_object".localized]
        let segmentedControl = UISegmentedControl(items: segmentedControlItems)
        segmentedControl.addTarget(self, action: #selector(didChangeSegmentedControlValue), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()

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
        view.addSubview(productTypeSegmentedControl)
        tableView.delegate = source
        tableView.dataSource = source
        bind(to: viewModel)
        viewModel.viewDidLoad()
        configure()
    }

    func configure() {
        view.backgroundColor = .white
        let safeArea = view.safeAreaLayoutGuide
        productTypeSegmentedControl.anchor(top: safeArea.topAnchor,
                                           left: safeArea.leftAnchor,
                                           right: safeArea.rightAnchor,
                                           height: 100)
        tableView.anchor(top: productTypeSegmentedControl.bottomAnchor,
                         left: safeArea.leftAnchor,
                         bottom: safeArea.bottomAnchor,
                         right: safeArea.rightAnchor,
                         paddingTop: 10)
    }

    // MARK: - Selectors

    @objc func didTapSearchButton() {
        guard let mode = source.dictionnaryOfCells["mode"] else { return }
        switch productTypeSegmentedControl.selectedSegmentIndex {
        case 0:
            guard let settings = source.dictionnaryOfCells["temperature"] else {return}
            viewModel.searchDeviceWithFilters(productType: "Heater",
                                              mode: mode,
                                              settings: "temperature",
                                              settingsValue: settings)
        case 1:
            guard let settings = source.dictionnaryOfCells["position"] else {return}
            viewModel.searchDeviceWithFilters(productType: "RollerShutter",
                                              mode: mode,
                                              settings: "position",
                                              settingsValue: settings)
        case 2:
            guard let settings = source.dictionnaryOfCells["intensity"] else {return}
            viewModel.searchDeviceWithFilters(productType: "Light",
                                              mode: mode,
                                              settings: "intensity",
                                              settingsValue: settings)
        default:
            return
        }

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

    @objc func didChangeSegmentedControlValue() {
        source.segmentedControlIndex = productTypeSegmentedControl.selectedSegmentIndex
        tableView.reloadData()
    }

}
