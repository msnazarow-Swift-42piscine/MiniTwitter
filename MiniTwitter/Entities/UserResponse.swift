//
//  UserResponse.swift
//  MiniTwitter
//
//  Created by out-nazarov2-ms on 25.09.2021.
//

import Foundation

struct UserResponse: Codable {
    let profileImageUrlHttps: String?
    let name: String?
    let screenName: String?
}
