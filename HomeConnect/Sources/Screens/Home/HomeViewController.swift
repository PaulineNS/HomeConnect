//
//  HomeViewController.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 24/09/2020.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - Properties

    private lazy var collectionView = UICollectionView()
    private lazy var source: HomeDataSource = HomeDataSource()
    private let viewModel: HomeViewModel

    // MARK: - Initializer

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - View life cycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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

    // MARK: - Configure UI

    private func setNavigationBar() {
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func setCollectionView() {
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.backgroundColor = .white
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionView.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionViewFlowLayout.minimumInteritemSpacing = 10
        collectionViewFlowLayout.minimumLineSpacing = 10
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: "deviceCell")
    }

    private func bind(to source: HomeDataSource) {
        source.selectedDevice = viewModel.didSelectItem
    }

    private func bind(to viewModel: HomeViewModel) {

        viewModel.homeTitle = { [weak self] title in
            self?.navigationController?.navigationBar.topItem?.title = title
        }
    }
}
