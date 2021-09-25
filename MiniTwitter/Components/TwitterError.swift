//
//  TwitterError.swift
//  MiniTwitter
//
//  Created by out-nazarov2-ms on 25.09.2021.
//

import Foundation

enum TwitterError: LocalizedError {
    case noResultFinding
    case noDataProduced

    var localizedDescription: String {
        switch self {
        case .noDataProduced:
            return "Ошибка обращения к API twitter"
        case .noResultFinding:
            return "Результатов не найдено, попробуйте изменить запрос"
        }
    }
}
