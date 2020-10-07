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

    var segmentedControlIndex = 0
    var dictionnaryOfCells: [String: String] = ["intensity": "0",
                                               "mode": "OFF",
                                               "name": "",
                                               "position": "0",
                                               "productType": "Heater",
                                               "temperature": "0"]

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        switch segmentedControlIndex {
        case 0, 2:
            return 2
        default:
            return 1
        }
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.row {
        case 0:
            return defineSettingsCell(tableView: tableView,
                                      cellForRowAt: indexPath)
        case 1:
            return defineModeCell(tableView: tableView,
                                  cellForRowAt: indexPath)

        default:
        return UITableViewCell()
        }
    }

    private func defineModeCell(tableView: UITableView,
                                cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch segmentedControlIndex {
        case 0, 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ModeFilterTableViewCell.identifier,
                                                           for: indexPath)
                    as? ModeFilterTableViewCell else { return UITableViewCell() }
            cell.configure(delegate: self)
            return cell
        default:
            return UITableViewCell()
        }
    }

    private func defineSettingsCell(tableView: UITableView,
                                    cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch segmentedControlIndex {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TemperatureFilterTableViewCell.identifier,
                                                           for: indexPath)
                    as? TemperatureFilterTableViewCell else { return UITableViewCell() }
            cell.configure(delegate: self)
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PositionFilterTableViewCell.identifier,
                                                           for: indexPath)
                    as? PositionFilterTableViewCell else { return UITableViewCell() }
            cell.configure(delegate: self)
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: IntensityFilterTableViewCell.identifier,
                                                           for: indexPath)
                    as? IntensityFilterTableViewCell else { return UITableViewCell() }
            cell.configure(delegate: self)
            return cell
        default:
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    /// Display the tableView footer depending the number of elements tableView
    func tableView(_ tableView: UITableView,
                   heightForFooterInSection section: Int) -> CGFloat {
        return tableView.bounds.size.height
    }

}

extension FiltersDataSource: ModeFilterTableViewCellDelegate {
    func didChangeModeSwitchValue(to value: Bool) {
        dictionnaryOfCells["mode"] = value ? "ON" : "OFF"
    }
}
extension FiltersDataSource: IntensityFilterTableViewCellDelegate {
    func didChangeIntensityValue(with value: String) {
        dictionnaryOfCells["intensity"] = value
    }
}

extension FiltersDataSource: TemperatureFilterTableViewCellDelegate {
    func didChangeTemperatureValue(with value: String) {
        dictionnaryOfCells["temperature"] = value
    }
}

extension FiltersDataSource: PositionFilterTableViewCellDelegate {
    func didChangePositionValue(with value: String) {
        dictionnaryOfCells["position"] = value
    }
}
