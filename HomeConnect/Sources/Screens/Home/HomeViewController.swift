//
//  HomeViewController.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 24/09/2020.
//

import UIKit

final class HomeViewController: UIViewController {

    // MARK: - Properties

    private lazy var source: HomeDataSource = HomeDataSource()
    private lazy var profileIconName: String = ""
    private lazy var filterIconName: String = ""
    private let viewModel: HomeViewModel

    private let collectionView: UICollectionView = {
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
        collection.backgroundColor = .white
        collection.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collection.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionViewFlowLayout.minimumInteritemSpacing = 10
        collectionViewFlowLayout.minimumLineSpacing = 10
        return collection
    }()

    private lazy var filterButton: UIBarButtonItem = {
        let filterButton = UIBarButtonItem(title: filterIconName,
                        style: .plain,
                        target: self,
                        action: #selector(didTapFilterButton))
        return filterButton
    }()

    private lazy var profileButton: UIBarButtonItem = {
        let profileButton = UIBarButtonItem(image: UIImage(named: profileIconName),
                                            style: .plain,
                                            target: self,
                                            action: #selector(didTapProfileButton))
        return profileButton
    }()

    private let backButtonItem: UIBarButtonItem = {
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        return backButton
    }()

    // MARK: - Initializer

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - View life cycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
        setNavigationBar()
        setCollectionView()
        collectionView.delegate = source
        collectionView.dataSource = source
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind(to: source)
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }

    // MARK: - Bindings

    private func bind(to source: HomeDataSource) {
        source.selectedDevice = viewModel.didSelectDevice
    }

    private func bind(to viewModel: HomeViewModel) {
        viewModel.homeTitle = { [weak self] title in
            self?.navigationController?.navigationBar.topItem?.title = title
        }
        viewModel.devicesDisplayed = { [weak self] devices in
            self?.source.updateCell(with: devices)
            self?.collectionView.reloadData()
        }
        viewModel.profileIconName = { [weak self] name in
            self?.profileIconName = name
        }
        viewModel.filterIconName = { [weak self] name in
            self?.filterIconName = name
        }
    }

    // MARK: - Configure UI

    private func setNavigationBar() {
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.backBarButtonItem = backButtonItem
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.1081894711, green: 0.1763972342, blue: 0.2618448138, alpha: 1)
        self.navigationItem.rightBarButtonItem  = filterButton
        self.navigationItem.leftBarButtonItem  = profileButton
    }

    private func setCollectionView() {
        view.addSubview(collectionView)
        collectionView.anchor(top: view.topAnchor,
                              left: view.leftAnchor,
                              bottom: view.bottomAnchor,
                              right: view.rightAnchor)
    }

    // MARK: - Selectors

    @objc func didTapProfileButton() {
        viewModel.didSelectProfileButton()
    }

    @objc func didTapFilterButton() {
        viewModel.didSelectFilterButton()
    }

}
