//
//  TwitterCell.swift
//  MiniTwitter
//
//  Created by out-nazarov2-ms on 25.09.2021.
//

import UIKit

class TwitterCell: Cell {
    let gap = CGFloat(10)

    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.numberOfLines = 0
        return label
    }()

    let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let tweetLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    lazy var tweetLabelPortraitOptionalConstraints = [
        profileImage.trailingAnchor.constraint(equalTo: tweetLabel.leadingAnchor, constant: -gap)
    ]

    lazy var tweetLabelLandscapeOptionalConstraints = [
        profileImage.bottomAnchor.constraint(equalTo: tweetLabel.topAnchor, constant: -gap),
        tweetLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: gap)
    ]

    lazy var tweetConstraints = [
        nameLabel.bottomAnchor.constraint(equalTo: tweetLabel.topAnchor, constant: -gap),
        dateLabel.bottomAnchor.constraint(equalTo: tweetLabel.topAnchor, constant: -gap),
        profileImage.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -gap),
        profileImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: gap),
        profileImage.trailingAnchor.constraint(equalTo: nameLabel.leadingAnchor, constant: -gap),
        profileImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: gap),
        profileImage.heightAnchor.constraint(equalTo: profileImage.widthAnchor),
        profileImage.widthAnchor.constraint(equalToConstant: 100),
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: gap),
        nameLabel.trailingAnchor.constraint(equalTo: dateLabel.leadingAnchor, constant: -gap),
        dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -gap),
        dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: gap),
        tweetLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -gap),
        tweetLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -gap)
    ]

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [nameLabel, dateLabel, tweetLabel, profileImage].forEach { contentView.addSubview($0) }
        NSLayoutConstraint.activate(tweetConstraints)
        NSLayoutConstraint.activate(tweetLabelPortraitOptionalConstraints)
    }

    override func updateViews() {
        guard let model = model as? TwitterCellModel else { return }
        let fullName = NSMutableAttributedString(string: model.fullName, attributes: [:])
        fullName.append(NSAttributedString(string: " @\(model.nickName)", attributes: [.foregroundColor: UIColor.lightGray]))
        nameLabel.attributedText = fullName
        dateLabel.text = model.dateString
        tweetLabel.text = model.tweet
        presenter?.getImage(for: model.profileImage) { image in
            DispatchQueue.main.async {
                self.profileImage.image = image
                self.profileImage.layer.cornerRadius = 0.5 * self.profileImage.layer.bounds.width
                self.updateConstraints()
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//  TODO: Lanscape layout
