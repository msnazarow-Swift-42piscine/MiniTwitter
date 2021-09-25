//
//  MainViewController.swift
//  MiniTwitter
//
//  Created by out-nazarov2-ms on 24.09.2021.
//  
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - Properties
    var presenter: ViewToPresenterMainProtocol?

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }

    private func setupUI() {
        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {

    }

    private func setupConstraints() {

    }
}

extension MainViewController: PresenterToViewMainProtocol{
    // TODO: Implement View Output Methods
}
