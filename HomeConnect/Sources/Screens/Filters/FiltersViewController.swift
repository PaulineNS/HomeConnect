//
//  FiltersViewController.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 24/09/2020.
//

import UIKit

class FiltersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Properties

    private let tableView: UITableView = {
        let table = UITableView()
//        table.register(SimpleTableViewCell.self,
//                       forCellReuseIdentifier: SimpleTableViewCell.identifier)
//        table.register(ImageTableViewCell.self,
//                       forCellReuseIdentifier: ImageTableViewCell.identifier)
        table.register(IntensityFilterTableViewCell.self,
                       forCellReuseIdentifier: IntensityFilterTableViewCell.identifier)
        table.register(ModeFilterTableViewCell.self,
                       forCellReuseIdentifier: ModeFilterTableViewCell.identifier)
        table.register(ProductTypeFilterTableViewCell.self,
                       forCellReuseIdentifier: ProductTypeFilterTableViewCell.identifier)
        table.register(PositionFilterTableViewCell.self,
                       forCellReuseIdentifier: PositionFilterTableViewCell.identifier)
        table.register(TemperatureFilterTableViewCell.self,
                       forCellReuseIdentifier: TemperatureFilterTableViewCell.identifier)
        return table
    }()

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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: IntensityFilterTableViewCell.identifier,
                                                           for: indexPath)
                    as? IntensityFilterTableViewCell else { return UITableViewCell() }
            cell.configure()
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ModeFilterTableViewCell.identifier,
                                                           for: indexPath)
                    as? ModeFilterTableViewCell else { return UITableViewCell() }
            cell.configure()
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductTypeFilterTableViewCell.identifier,
                                                           for: indexPath)
                    as? ProductTypeFilterTableViewCell else { return UITableViewCell() }
            cell.configure()
            return cell

        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PositionFilterTableViewCell.identifier,
                                                           for: indexPath)
                    as? PositionFilterTableViewCell else { return UITableViewCell() }
            cell.configure()
            return cell

        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TemperatureFilterTableViewCell.identifier,
                                                           for: indexPath)
                    as? TemperatureFilterTableViewCell else { return UITableViewCell() }
            cell.configure()
            return cell

        default:
            return UITableViewCell()
        }

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

}
