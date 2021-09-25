//
//  SectionModel.swift
//  MiniTwitter
//
//  Created by out-nazarov2-ms on 24.09.2021.
//  
//

import Foundation

final class SectionModel: SectionRowsRepresentable {
    var rows: [CellIdentifiable] = []

    init(_ properties: [TweetResponse]) {
        properties.forEach { property in
            rows.append(CellModel(property))
        }
    }
}
