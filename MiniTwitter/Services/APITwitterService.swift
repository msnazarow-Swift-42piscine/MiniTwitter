//
//  APITwitterService.swift
//  MiniTwitter
//
//  Created by out-nazarov2-ms on 24.09.2021.
//

import Foundation

protocol APITwitterServiceProtocol: AnyObject {
    func getRecentTweets(with substring: String, number: Int, complition: @escaping (Result<[TweetResponse], Error>) -> Void)
}

class APITwitterService: APITwitterServiceProtocol {
    let accessToken = "AAAAAAAAAAAAAAAAAAAAAO3k9gAAAAAAYiCjT11ullplhI%2FwD7DfpQCK2B0%3De7YvgUGT6pCgqAFbq0qqyKvWxlIwgqsjGV6WVTBzrTJpzTYGTk"
    let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    func getRecentTweets(with substring: String, number: Int, complition: @escaping (Result<[TweetResponse], Error>) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.twitter.com"
        urlComponents.path = "/1.1/search/tweets.json"
        urlComponents.queryItems = [
            .init(name: "q", value: substring),
            .init(name: "lang", value: "ru"),
            .init(name: "result_type", value: "recent"),
            .init(name: "count", value: "\(number)"),
            .init(name: "tweet_mode", value: "extended"),
            .init(name: "display_text_range", value: "-1")
        ]
        var request = URLRequest(url: urlComponents.url!)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                complition(.failure(error))
                return
            }
            guard let data = data else {
                complition(.failure(TwitterError.noDataProduced))
                return
            }
            do {
                if let tweets = (try self.decoder.decode(SearchResponse.self, from: data)).statuses {
                    complition(.success(tweets))
                } else {
                    complition(.failure(TwitterError.noResultFinding))
                }
            } catch {
                complition(.failure(error))
            }
        }.resume()
    }
}
