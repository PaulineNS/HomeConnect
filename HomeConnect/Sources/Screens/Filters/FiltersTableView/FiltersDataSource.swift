//
//  FiltersDataSource.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 01/10/2020.
//

import UIKit

final class FiltersDataSource: NSObject,
                               UITableViewDelegate,
                               UITableViewDataSource {

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

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

    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

}
