//
//  TwitterCell.swift
//  MiniTwitter
//
//  Created by out-nazarov2-ms on 25.09.2021.
//

import UIKit

class TwitterCell: Cell {
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let tweetLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [nameLabel, dateLabel, tweetLabel, profileImage].forEach{ contentView.addSubview($0)}
        NSLayoutConstraint.activate([
            profileImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            profileImage.trailingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            profileImage.trailingAnchor.constraint(equalTo: tweetLabel.leadingAnchor),
            profileImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            profileImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: tweetLabel.topAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: tweetLabel.topAnchor),
            tweetLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tweetLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    override func updateViews() {
        guard let model = model as? CellModel else { return }
        let fullName = NSMutableAttributedString(string: model.fullName, attributes: [.font: UIFont.boldSystemFont(ofSize: 26)])
        fullName.append(NSAttributedString(string: " @\(model.nickName)", attributes: [.font: UIFont.systemFont(ofSize: 20), .foregroundColor: UIColor.lightGray]))
        nameLabel.attributedText = fullName
        dateLabel.text = model.dateString
        tweetLabel.text = model.tweet
        presenter?.getImage(for: model.profileImage){[self] image in
            profileImage.image = image
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
