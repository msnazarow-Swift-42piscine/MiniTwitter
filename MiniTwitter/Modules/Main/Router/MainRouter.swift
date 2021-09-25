//
//  MainRouter.swift
//  MiniTwitter
//
//  Created by out-nazarov2-ms on 24.09.2021.
//
//

import UIKit

class MainRouter: PresenterToRouterMainProtocol {
    // MARK: - Properties

    weak var view: UIViewController?

    // MARK: - Init

    init(view: UIViewController) {
        self.view = view
    }
}
