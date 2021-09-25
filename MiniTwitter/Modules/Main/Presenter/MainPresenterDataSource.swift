//
//  MainPresenterDataSource.swift
//  MiniTwitter
//
//  Created by out-nazarov2-ms on 24.09.2021.
//  
//

import UIKit

class MainPresenterDataSource: NSObject, PresenterToDataSourceMainProtocol {

    // MARK: Properties
    weak var presenter: CellToPresenterMainProtocol?

    private var sections: [SectionModel] = []

    func updateForSections(_ sections: [SectionModel]) {
        self.sections = sections
    }

    func numberOfSections(in _: UITableView) -> Int {
        return sections.count
    }

    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = sections[indexPath.section].rows[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: model.cellIdentifier, for: indexPath) as? Cell else {
            return UITableViewCell()
        }
        cell.presenter = presenter
        cell.model = model
        return cell
    }
}
