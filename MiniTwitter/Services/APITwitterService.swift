//
//  APITwitterService.swift
//  MiniTwitter
//
//  Created by out-nazarov2-ms on 24.09.2021.
//

import Foundation

let API_KEY = "F2OuE6PdVN0lGUS1xrvLxrNYK"
let API_SECRET_KEY = "RUDxXB5XtziUR5p5vPG5bis0hOYbmuoQspsEgnpAPZfpuEopVs"
let BEARER = ((API_KEY + ":" + API_SECRET_KEY).data(using: String.Encoding.utf8))!.base64EncodedString()
let bearer = "RjJPdUU2UGRWTjBsR1VTMXhydkx4ck5ZSzpSVUR4WEI1WHR6aVVSNXA1dlBHNWJpczBoT1libXVvUXNwc0VnbnBBUFpmcHVFb3BWcw=="

protocol APITwitterServiceProtocol: AnyObject {
    func getRecentTweets(with substring: String, number: Int, complition: @escaping (Result<[TweetResponse], Error>) ->Void)
}

class APITwitterService: APITwitterServiceProtocol {
    let access_token = "AAAAAAAAAAAAAAAAAAAAAO3k9gAAAAAAYiCjT11ullplhI%2FwD7DfpQCK2B0%3De7YvgUGT6pCgqAFbq0qqyKvWxlIwgqsjGV6WVTBzrTJpzTYGTk"
    let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    func getRecentTweets(with substring: String, number: Int, complition: @escaping (Result<[TweetResponse], Error>) ->Void){
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.twitter.com"
        urlComponents.path = "/1.1/search/tweets.json"
        urlComponents.queryItems = [
            .init(name: "q", value: substring),
            .init(name: "lang", value: "en"),
            .init(name: "result_type", value: "recent"),
            .init(name: "count", value: "100"),
            .init(name: "tweet_mode", value: "extended"),
            .init(name: "display_text_range", value: "-1")
        ]
        var request = URLRequest(url: urlComponents.url!)
        request.setValue("Bearer \(access_token)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                if let tweets = (try self.decoder.decode(SearchResponse.self, from: data)).statuses {
                    complition(.success(tweets))
                } else {
                    complition(.failure(TwitterError.NoResultFinding))
                }
            } catch {
                complition(.failure(error))
            }
        }.resume()
    }
}
