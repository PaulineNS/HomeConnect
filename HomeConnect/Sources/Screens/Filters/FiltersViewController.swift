//
//  FiltersViewController.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 24/09/2020.
//

import UIKit

final class FiltersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Properties

    private let viewModel: FiltersViewModel

    private let tableView: UITableView = {
        let table = UITableView()
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
        let updateButton = UIBarButtonItem(title: "Chercher",
                        style: .plain,
                        target: self,
                        action: #selector(didTapSearchButton))
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
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductTypeFilterTableViewCell.identifier,
                                                           for: indexPath)
                    as? ProductTypeFilterTableViewCell else { return UITableViewCell() }
            cell.configure()
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ModeFilterTableViewCell.identifier,
                                                           for: indexPath)
                    as? ModeFilterTableViewCell else { return UITableViewCell() }
            cell.configure()
            return cell
        case 2:

            guard let cell = tableView.dequeueReusableCell(withIdentifier: IntensityFilterTableViewCell.identifier,
                                                           for: indexPath)
                    as? IntensityFilterTableViewCell else { return UITableViewCell() }
            cell.configure()
            cell.intensitySlider.addTarget(cell, action: #selector(cell.didMoveIntensitySlider), for: .valueChanged)
            return cell

        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PositionFilterTableViewCell.identifier,
                                                           for: indexPath)
                    as? PositionFilterTableViewCell else { return UITableViewCell() }
            cell.configure()
            cell.positionSlider.addTarget(cell, action: #selector(cell.didMovePositionSlider), for: .valueChanged)
            return cell

        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TemperatureFilterTableViewCell.identifier,
                                                           for: indexPath)
                    as? TemperatureFilterTableViewCell else { return UITableViewCell() }
            cell.configure()
            cell.heaterMinusButton.addTarget(cell, action: #selector(cell.didTapMinusButton), for: .touchUpInside)
            cell.heaterPlusButton.addTarget(cell, action: #selector(cell.didTapPlusButton), for: .touchUpInside)
            return cell

        default:
            return UITableViewCell()
        }

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    // MARK: - Selectors

    @objc func didTapSearchButton() {
        viewModel.searchDeviceWithFilters()
    }

    // MARK: - Configure UI

    private func setNavigationBar() {
        self.navigationItem.rightBarButtonItem  = searchButton
    }

}
