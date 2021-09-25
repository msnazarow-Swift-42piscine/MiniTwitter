//
//  SearchResponse.swift
//  MiniTwitter
//
//  Created by out-nazarov2-ms on 25.09.2021.
//

import Foundation

struct SearchResponse: Codable {
    let statuses: [TweetResponse]?
}
