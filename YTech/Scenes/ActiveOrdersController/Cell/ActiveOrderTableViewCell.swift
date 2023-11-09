//
//  ActiveOrderTableViewCell.swift
//  YTech
//
//  Created by Muhammet  on 8.11.2023.
//

import UIKit

final class ActiveOrderTableViewCell: UITableViewCell {
    
    enum Identifier: String {
        case custom = "cell"
    }
    let customCellComponent = CustomCellComponent()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(customCellComponent)
        customCellComponent.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(with model: ContentResult) {
        customCellComponent.configureCells(model: model, isPastOrderVC: false)
    }
}
