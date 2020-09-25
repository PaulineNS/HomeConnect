//
//  HomeDataSource.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 24/09/2020.
//

import UIKit

final class HomeDataSource: NSObject {

    // MARK: - Public properties

    private var devices: [DeviceResponse.Device] = []
    var selectedDevice: ((DeviceResponse.Device) -> Void)?

    // MARK: - Methods

    func updateCell (with devices: [DeviceResponse.Device]) {
        self.devices = devices
    }

}

extension HomeDataSource: UICollectionViewDataSource,
                          UICollectionViewDelegate {

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return devices.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "deviceCell",
                                                            for: indexPath) as? HomeCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.autoLayoutCell()
        cell.updateCell(with: devices[indexPath.row])
//        cell.updateCell(with: devices[indexPath.row].devices)
//        cell.updateCell(with: devices[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.row < devices.count else { return }
        selectedDevice?(devices[indexPath.row])
    }

}

extension HomeDataSource: UICollectionViewDelegateFlowLayout {

    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.size.width - 3 * 10) / 2
        let height = width
        return CGSize(width: width, height: height)
    }

}
