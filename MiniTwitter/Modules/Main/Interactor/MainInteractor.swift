//
//  MainInteractor.swift
//  MiniTwitter
//
//  Created by out-nazarov2-ms on 24.09.2021.
//  
//

import Foundation
import UIKit

class MainInteractor: PresenterToInteractorMainProtocol {
    weak var presenter: InteractortoPresenterMainProtocol!

    let apiTwitterService: APITwitterServiceProtocol
    let imageCashingService: ImageCashingServiceProtocol
    init(apiTwitterService: APITwitterServiceProtocol, imageCashingService: ImageCashingServiceProtocol){
        self.apiTwitterService = apiTwitterService
        self.imageCashingService = imageCashingService
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

    func getImage(for url: String, comlition: @escaping (UIImage?) -> Void) {
        imageCashingService.getImage(for: url) { image in
            comlition(image)
        }
    }
}
