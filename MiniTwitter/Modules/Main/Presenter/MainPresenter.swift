//
//  MainPresenter.swift
//  MiniTwitter
//
//  Created by out-nazarov2-ms on 24.09.2021.
//  
//

import Foundation
import UIKit

class MainPresenter: ViewToPresenterMainProtocol {

    // MARK: Properties
    weak var view: PresenterToViewMainProtocol?
    let interactor: PresenterToInteractorMainProtocol?
    let router: PresenterToRouterMainProtocol?
    let dataSource:PresenterToDataSourceMainProtocol?

    // MARK: Init
    init(view: PresenterToViewMainProtocol,
         interactor: PresenterToInteractorMainProtocol?,
         router: PresenterToRouterMainProtocol?,
         dataSource: PresenterToDataSourceMainProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.dataSource = dataSource
    }

    func viewDidLoad(){
        guard let view = view, let interactor = interactor else {
            return
        }
        view.setSearchString(with: "\"Школа 21\"")
        let searchText = view.getSearchString()
        if !searchText.isEmpty {
            interactor.getRecentTweets(with: searchText, number: 100)
        }
    }

    func didTapReturn(from searchText: String) {
        if !searchText.isEmpty {
            interactor?.getRecentTweets(with: searchText, number: 100)
        }
    }
}

extension MainPresenter: CellToPresenterMainProtocol {
    func getImage(for imageURL: String, complition: @escaping (UIImage?) -> Void) {
        interactor?.getImage(for: imageURL){ image in
            complition(image)
        }
    }
}


extension MainPresenter: InteractortoPresenterMainProtocol {
    func didDownloadTweets(_ tweets: [TweetResponse]) {
        if !tweets.isEmpty {
            dataSource?.updateForSections([SectionModel(tweets)])
            view?.reloadTableViewData()
        } else {
            print(TwitterError.NoResultFinding.localizedDescription)
        }
    }

    func didCatchError(_ error: Error) {
        do{
            throw error
        } catch let DecodingError.dataCorrupted(context) {
          print("data corrupted:", context)
        } catch let DecodingError.keyNotFound(key, context) {
          print("Key '\(key)' not found:", context.debugDescription)
          print("codingPath:", context.codingPath)
        } catch let DecodingError.valueNotFound(value, context) {
          print("Value '\(value)' not found:", context.debugDescription)
          print("codingPath:", context.codingPath)
        } catch let DecodingError.typeMismatch(type, context) {
          print("Type '\(type)' mismatch:", context.debugDescription)
          print("codingPath:", context.codingPath)
        } catch {
          print(error.localizedDescription)
        }
    }
}
