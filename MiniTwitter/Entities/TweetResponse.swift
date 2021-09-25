//
//  TweetResponse.swift
//  MiniTwitter
//
//  Created by out-nazarov2-ms on 25.09.2021.
//

import Foundation

struct TweetResponse: Codable {
    let createdAt: String?
    let fullText: String?
    let user: UserResponse?
    let retweetedStatus: RetweetedStatusResponse?
}
