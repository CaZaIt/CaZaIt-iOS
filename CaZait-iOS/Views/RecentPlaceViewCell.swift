//
//  RecentPlaceViewCell.swift
//  CaZait-iOS
//
//  Created by 강석호 on 2023/04/07.
//

import Foundation

import UIKit

class RecentPlaceViewCell: UITableViewCell {

    // 이미지와 라벨을 위한 뷰 생성
    let myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    let myLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // 셀 생성
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // 이미지와 라벨을 셀에 추가
        contentView.addSubview(myImageView)
        contentView.addSubview(myLabel)

        // 제약 조건 설정
        NSLayoutConstraint.activate([
            myImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            myImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            myImageView.widthAnchor.constraint(equalToConstant: 40),
            myImageView.heightAnchor.constraint(equalToConstant: 40),

            myLabel.leadingAnchor.constraint(equalTo: myImageView.trailingAnchor, constant: 8),
            myLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            myLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
