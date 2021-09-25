//
//  MainViewController.swift
//  MiniTwitter
//
//  Created by out-nazarov2-ms on 24.09.2021.
//  
//

import UIKit

class MainViewController: UITableViewController {
    // MARK: - Properties
    var presenter: ViewToPresenterMainProtocol?

    lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        textField.addTarget(self, action: #selector(didTapReturn), for: .editingDidEndOnExit)
        return textField
    }()

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }

    private func setupUI() {
        addSubviews()
        setupConstraints()
        tableView.dataSource = presenter?.dataSource
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        tableView.register(TwitterCell.self, forCellReuseIdentifier: String(describing: TwitterCell.self))
        title = "Tweets"
        tableView.tableHeaderView = searchTextField
        searchTextField.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
    }

    private func addSubviews() {
    }

    private func setupConstraints() {
    }

    @objc private func didTapReturn(_ sender: UITextField) {
        presenter?.didTapReturn(from: sender.text ?? "")
    }
}

extension MainViewController: PresenterToViewMainProtocol {
    func getSearchString() -> String {
        return searchTextField.text ?? ""
    }

    func setSearchString(with searchString: String) {
        searchTextField.text = searchString
    }

    func reloadTableViewData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }

    func showAlert(with message: String) {
        DispatchQueue.main.async { [self] in
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
}
