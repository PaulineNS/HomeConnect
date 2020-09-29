//
//  UpdateProfileViewController.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 29/09/2020.
//

import UIKit

class UpdateProfileViewController: UIViewController {

    // MARK: - Properties

    private lazy var saveInformationsButton: UIBarButtonItem = {
        let updateButton = UIBarButtonItem(title: "Enregistrer",
                        style: .plain,
                        target: self,
                        action: #selector(didTapUpdateProfileButton))
        return updateButton
    }()

    // MARK: - Lifecycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red

        // Do any additional setup after loading the view.
    }

    // MARK: - Selectors

    @objc func didTapUpdateProfileButton() {

    }

    // MARK: - Configure UI

    private func setNavigationBar() {
        self.navigationItem.rightBarButtonItem  = saveInformationsButton
    }
}
