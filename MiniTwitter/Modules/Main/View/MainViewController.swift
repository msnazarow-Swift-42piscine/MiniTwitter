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

    lazy var searchTextField: SearchTextField = {
        let textField = SearchTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(didTapReturn), for: .editingDidEndOnExit)
        textField.backgroundColor = .purple.withAlphaComponent(0.1)
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
    }

    private func addSubviews() {
        tableView.tableHeaderView = searchTextField
    }

    private func setupConstraints() {
        searchTextField.centerXAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.centerXAnchor).isActive = true
        searchTextField.widthAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.widthAnchor).isActive = true
        searchTextField.heightAnchor.constraint(equalToConstant: 50 * verticalTranslation).isActive = true
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
