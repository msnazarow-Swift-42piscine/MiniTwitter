//
//  SearchTextField.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 07.09.2021.
//

import UIKit

final class SearchTextField: DesignableUITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)

        leftImage = .search
        leftPadding = 7
        rightPadding = 7
//        layer.backgroundColor = UIColor.grey0922.cgColor
        layer.cornerRadius = 8
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
