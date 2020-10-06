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

//    weak var delegate: ProductTypeFilterTableViewCellDelegate?
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
        return 2
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ModeFilterTableViewCell.identifier,
                                                           for: indexPath)
                    as? ModeFilterTableViewCell else { return UITableViewCell() }
            cell.configure()
            cell.delegate = self
//            cell.modeStackView.tag = 0
            cell.modeSwitch.addTarget(cell, action: #selector(cell.didChangeSwitchValue), for: .valueChanged)
            cell.selectionStyle = .none
            return cell
        case 1:
            return hgjhj(tableView: tableView, cellForRowAt: indexPath)
        default:
        return UITableViewCell()
        }
    }

    func hgjhj(tableView: UITableView,
               cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch segmentedControlIndex {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TemperatureFilterTableViewCell.identifier,
                                                           for: indexPath)
                    as? TemperatureFilterTableViewCell else { return UITableViewCell() }
            cell.configure()
            cell.delegate = self
            cell.selectionStyle = .none
            cell.temperatureLabel.tag = 3
            cell.heaterMinusButton.addTarget(cell, action: #selector(cell.didTapMinusButton), for: .touchUpInside)
            cell.heaterPlusButton.addTarget(cell, action: #selector(cell.didTapPlusButton), for: .touchUpInside)
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PositionFilterTableViewCell.identifier,
                                                           for: indexPath)
                    as? PositionFilterTableViewCell else { return UITableViewCell() }
            cell.configure()
            cell.delegate = self
            cell.selectionStyle = .none
            cell.positionSliderValue.tag = 2
            cell.positionSlider.addTarget(cell, action: #selector(cell.didMovePositionSlider), for: .valueChanged)
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: IntensityFilterTableViewCell.identifier,
                                                           for: indexPath)
                    as? IntensityFilterTableViewCell else { return UITableViewCell() }
            cell.configure()
            cell.delegate = self
            cell.selectionStyle = .none
            cell.intensitySliderValue.tag = 1
            cell.intensitySlider.addTarget(cell, action: #selector(cell.didMoveIntensitySlider), for: .valueChanged)
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
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return tableView.bounds.size.height
    }

}

extension FiltersDataSource: ModeFilterTableViewCellDelegate {
    func didChangeModeSwitchValue(to value: Bool) {
        dictionnaryOfCells["mode"] = value ? "ON" : "OFF"
        print(dictionnaryOfCells)
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
