//
//  MainInteractor.swift
//  MiniTwitter
//
//  Created by out-nazarov2-ms on 24.09.2021.
//  
//

import Foundation

class MainInteractor: PresenterToInteractorMainProtocol {
    weak var presenter: InteractortoPresenterMainProtocol!

    let apiTwitterService: APITwitterServiceProtocol

    init(apiTwitterService: APITwitterServiceProtocol){
        self.apiTwitterService = apiTwitterService
    }

    func getRecentTweets(with substring: String, number: Int){
        apiTwitterService.getRecentTweets(with: substring, number: number) {[weak self] result in
            switch result{
            case .success(let tweets):
                self?.presenter.didDownloadTweets(tweets)
            case .failure(let error):
                self?.presenter.didCatchError(error)
            }
        }
    }
}
