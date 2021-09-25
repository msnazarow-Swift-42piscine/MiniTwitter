//
//  CellModel.swift
//  MiniTwitter
//
//  Created by out-nazarov2-ms on 24.09.2021.
//  
//

import Foundation

struct Model {

}

struct CellModel: CellIdentifiable {

    var cellIdentifier: String { return "Cell" }

    let fullName: String
    let nickName: String
    var dateString: String
    let tweet: String
    let profileImage: String
//https://twitter.com/EvgenyFeldman
    init(_ property: TweetResponse) {
        fullName = property.name?.name ?? ""
        nickName = property.name?.screenName ?? ""
        dateString = property.createdAt ?? ""
        tweet = property.fullText ?? ""
        profileImage = property.name?.profileImageUrlHttps ?? ""
        guard let date = DateFormatter.twitterDateFormatter.date(from: dateString) else { return }
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        self.dateString = formatter.localizedString(for: date, relativeTo: Date())
    }
}
