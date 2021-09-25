//
//  CellModel.swift
//  MiniTwitter
//
//  Created by out-nazarov2-ms on 24.09.2021.
//  
//

import Foundation

struct TwitterCellModel: CellIdentifiable {

    var cellIdentifier: String { return "TwitterCell" }

    let fullName: String
    let nickName: String
    var dateString: String
    let tweet: String
    let profileImage: String

    init(_ property: TweetResponse) {
        fullName = property.user?.name ?? ""
        nickName = property.user?.screenName ?? ""
        dateString = property.createdAt ?? ""

        tweet = property.retweetedStatus?.fullText ?? property.fullText ?? ""
        profileImage = property.user?.profileImageUrlHttps ?? ""
        guard let date = DateFormatter.twitterDateFormatter.date(from: dateString) else { return }
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        self.dateString = formatter.localizedString(for: date, relativeTo: Date())
    }
}
