//
//  SearchTableViewCell.swift
//  CaZait-iOS
//
//  Created by 강민수 on 2023/05/17.
//

import Foundation
import SnapKit

class SearchTableViewCell: UITableViewCell {
    
    //이동하려는 viewController가 navigationController 내에서 push될 수 있도록 navigationController를 추가
    weak var navigationController: UINavigationController?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

