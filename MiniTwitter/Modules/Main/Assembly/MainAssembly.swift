//
//  MainAssembly.swift
//  MiniTwitter
//
//  Created by out-nazarov2-ms on 24.09.2021.
//
//

import UIKit

enum MainAssembly {
    // MARK: Static methods

    static func createModule() -> UIViewController {
        let viewController = MainViewController()
        let router = MainRouter(view: viewController)
        let apiTwitterService = APITwitterService()
        let imageCashingService = ImageCashingService()
        let interactor = MainInteractor(apiTwitterService: apiTwitterService, imageCashingService: imageCashingService)
        let dataSource = MainPresenterDataSource()
        let presenter = MainPresenter(view: viewController, interactor: interactor, router: router, dataSource: dataSource)

        viewController.presenter = presenter
        dataSource.presenter = presenter
        interactor.presenter = presenter

        return viewController
    }
}
