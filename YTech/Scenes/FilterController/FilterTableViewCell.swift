//
//  FilterTableViewCell.swift
//  YTech
//
//  Created by Muhammet  on 9.11.2023.
//

import UIKit
import SnapKit

class FilterTableViewCell: UITableViewCell {
    
    enum Identifier: String {
        case custom = "cell"
    }
     let label: UILabel = {
        let label = UILabel()
         return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(label)
  
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(12)
            make.height.equalTo(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
