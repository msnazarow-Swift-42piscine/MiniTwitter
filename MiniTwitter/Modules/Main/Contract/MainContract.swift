//
//  MainContract.swift
//  MiniTwitter
//
//  Created by out-nazarov2-ms on 24.09.2021.
//
//

import UIKit

// MARK: View Output (Presenter -> View)

protocol PresenterToViewMainProtocol: AnyObject {
    func getSearchString() -> String
    func setSearchString(with searchString: String)
    func reloadTableViewData()
    func showAlert(with message: String)
}

// MARK: View Input (View -> Presenter)

protocol ViewToPresenterMainProtocol: AnyObject {
    var dataSource: PresenterToDataSourceMainProtocol? { get }

    func didTapReturn(from searchText: String)
    func viewDidLoad()
}

// MARK: Interactor Input (Presenter -> Interactor)

protocol PresenterToInteractorMainProtocol: AnyObject {
    func getRecentTweets(with substring: String, number: Int)
    func getImage(for url: String, comlition: @escaping (UIImage?) -> Void)
}

// MARK: Presenter Output (Presenter -> Router)

protocol PresenterToRouterMainProtocol: AnyObject {}

// MARK: Presenter Output (Presenter -> DataSource)

protocol PresenterToDataSourceMainProtocol: UITableViewDataSource {
    func updateForSections(_ sections: [SectionModel])
}

// MARK: Cell Input (Cell -> Presenter)

protocol CellToPresenterMainProtocol: AnyObject {
    func getImage(for imageURL: String, complition: @escaping (UIImage?) -> Void)
}

protocol InteractortoPresenterMainProtocol: AnyObject {
    func didDownloadTweets(_ tweets: [TweetResponse])
    func didCatchError(_ error: Error)
}
