//
//  Cell.swift
//  MiniTwitter
//
//  Created by out-nazarov2-ms on 24.09.2021.
//  
//

import UIKit

class Cell: UITableViewCell, ModelRepresentable {
    weak var presenter: CellToPresenterMainProtocol?

    var model: CellIdentifiable? {
        didSet {
            updateViews()
        }
    }

    func updateViews() {}
}
